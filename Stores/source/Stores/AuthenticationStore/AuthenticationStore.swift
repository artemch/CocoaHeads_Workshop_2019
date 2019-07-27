import Foundation
import ReactiveSwift
import BackendServices
import ReactiveSwiftKit
import Result
import Services
import Models
import Validators
import SharedLocalization

final public class AuthenticationStore: AuthenticationStoreProtocol {
    
    public let model: MutableProperty<Model>
    
    // MARK: - Private properties
    
    private let (lifetime, token) = Lifetime.make()
    
    private let loginService: LoginService
    
    private let signUpService: SignUpService
    
    private let autoAuthService: AutoAuthenticationService
    
    private let resetPasswordService: ResetPasswordBackendService
    
    // MARK: - Initializations and Deallocations
    
    public init(loginService: LoginService,
                signUpService: SignUpService,
                autoAuthService: AutoAuthenticationService,
                resetPasswordService: ResetPasswordBackendService) {
        self.model = MutableProperty(.default)
        self.loginService = loginService
        self.signUpService = signUpService
        self.autoAuthService = autoAuthService
        self.resetPasswordService = resetPasswordService
    }
    
    // MARK: - Public methods
    
    public func signInWithEmail() -> SignalProducer<AuthResult, StoreError> {
        //Snipptes AS_1_1 - 1_2
        let model = self.model.value
        let email = model.email
        let password = model.password
        
        return loginValidation(email: email,
                               password: password)
            .mapError(F.Error.transform)
            .flatMap(FlattenStrategy.latest) {
                self.loginService.login(credential: .email(email, password: password)).mapError(F.Error.transform) }
            .observeOnMain()
            .on(event: { [weak self] event in
                switch event {
                case .value(let value):
                    self?.update(authResult: value)
                default: break
                }
            })
    }
    
    public func resetPassword() {
        //Snippets AS_2_1 - 2_3
        let model = self.model.value
        let email = model.email
        self.model.value = model
            |> Model.resetPasswordLens * AuthenticationStoreDomain.ResetPassword.loadingLens *~ .loading
        
        isValidEmail(email: email)
            .mapError(F.Error.transform)
            .flatMap(FlattenStrategy.latest) {
                self.resetPasswordService
                    .post(request: Request.ResetPassword(email: email))
                    .mapError(F.Error.transform)
            }
            .observeOnMain()
            .startWithResult { [weak self] result in
                var isLinkSent = false
                var loading: LoadingState<AuthenticationStoreDomain.ResetPasswordError> = .none
                switch result {
                case .success:
                    isLinkSent = true
                case .failure(let error):
                    isLinkSent = false
                    loading = .error(FP.transform(value: error))
                }
                self.do {
                    $0.model.value = $0.model.value
                        |> Model.resetPasswordLens * AuthenticationStoreDomain.ResetPassword.isLinkSentLens *~ isLinkSent
                        |> Model.resetPasswordLens * AuthenticationStoreDomain.ResetPassword.loadingLens *~ loading
                }
        }
    }
    
    public func clearPassword() {
        self.update(password: "")
    }
    
    public func clearEmail() {
        self.update(email: "")
    }
    
    public func update(email: String) {
        self.model.value = self.model.value |> Model.emailLens *~ email
    }
    
    public func update(password: String) {
        self.model.value = self.model.value |> Model.passwordLens *~ password
    }
    
    public func toggleIsAgree() {
        self.model.value = self.model.value |> Model.isAgreeLens *~ !self.model.value.isAgree
    }
    
    public func update(fullName: String?) {
        self.model.value = self.model.value |> Model.displayNameLens *~ fullName
    }
    
    public func signUpWithEmail() -> SignalProducer<AuthResult, StoreError> {
        let model = self.model.value
        let email = model.email
        let password = model.password
        let fullName = model.displayName
        let isAgree = model.isAgree
        let signUpService = self.signUpService
        
        return FP.isAgree(isAgree: isAgree)
            .flatMap(.latest) { FP.displayNameValidation(fullName: fullName) }
            .flatMap(.latest) { _ in Validators.signUpValidation(email: email, password: password).mapError(F.Error.transform) }
            .flatMap(.latest) {
                return signUpService.signUp(credential: .email(email, password: password, displayName: fullName)).mapError(F.Error.transform) }
            .take(during: self.lifetime)
            .observeOnMain()
            .on(event: { [weak self] event in
                switch event {
                case .value(let value):
                    self?.update(authResult: value)
                default: break
                }
            })
    }
    
    public func signInWithGoogle() -> SignalProducer<AuthResult, StoreError> {
        return self.loginService
            .login(credential: .google)
            .mapError(F.Error.transform)
            .take(during: self.lifetime)
            .observeOnMain()
            .on(event: { [weak self] event in
                switch event {
                case .value(let value):
                    self?.update(authResult: value)
                default: break
                }
            })
    }
    
    public func clearResetPasword() {
        self.model.value = self.model.value |> Model.resetPasswordLens *~ .default
    }
    
    public func clearResetPasswordError() {
        let model = self.model.value
        switch model.resetPassword.loading {
        case .error:
            self.model.value = model
                |> Model.resetPasswordLens * AuthenticationStoreDomain.ResetPassword.loadingLens *~ .none
        case .loading, .none:
            break
        }
    }
    
    public func autoAuth() -> SignalProducer<AuthResult, StoreError>  {
        return self.autoAuthService
            .auth()
            .observeOnMain()
            .mapError(F.Error.transform)
            .on(event: { [weak self] event in
                switch event {
                case .value(let value):
                    self?.update(authResult: value)
                default: break
                }
            })
    }
    
    // MARK: - Private methods
    
    private func update(authResult: AuthResult?) {
        self.model.value = self.model.value |> Model.authResultLens *~ authResult
    }
}

fileprivate extension AuthenticationStore {
    enum FP {}
}

fileprivate extension AuthenticationStore.FP {
    static func isAgree(isAgree: Bool) -> SignalProducer<Void, StoreError> {
        return SignalProducer<Void, StoreError> { (observer, lifetime) in
            if isAgree {
                observer.send(value: ())
                observer.sendCompleted()
            } else {
                observer.send(error: StoreError.invalidFields(FieldsError(errors: ["isAgree": L10n.Errors.agreeWithTermsAndConditions])))
        } }
    }
}

fileprivate extension AuthenticationStore.FP {
    static func displayNameValidation(fullName: String?) -> SignalProducer<Void, StoreError> {
        return F.displayNameValidation(fullName: fullName)
    }
}

fileprivate extension AuthenticationStore.FP {
    static func transform(value: StoreError) -> AuthenticationStoreDomain.ResetPasswordError {
        switch value {
        case .invalidFields(let fields):
            return .email(fields.email ?? L10n.Errors.undefinedEmailError)
        case .error(let reason):
            return .error(reason: reason)
        }
    }
}
