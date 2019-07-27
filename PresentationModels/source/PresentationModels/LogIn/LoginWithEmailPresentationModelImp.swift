import Foundation
import ReactiveSwift
import Services
import Validators
import Models
import Result
import ReactiveSwiftKit
import BackendServices
import Stores
import SharedLocalization

public class LoginWithEmailPresentationModelImp: PresentationModelImp<LoginWithEmailViewData>, LoginWithEmailPresentationModel, LoginWithEmailPresentationModelActionEvent {
    
    typealias Error = StoreError
    
    public var actionEvent: EventSignalType {
        return self.actionEventEmitter.event
    }
    
    // MARK: - Private properties
    
    private let actionEventEmitter = EventEmitter<EventSignalType.Value>()
    
    private let store: AuthenticationStoreProtocol
    
    private let emailError = MutableProperty<String?>(nil)
    
    private let passwordError = MutableProperty<String?>(nil)
    
    private let isShowPassword = MutableProperty(false)
    
    private let isLoading = MutableProperty(false)
    
    private let alertError = MutableProperty<AlertError?>(nil)
    
    // MARK: - Initializations and Deallocations
    
    public init(store: AuthenticationStoreProtocol) {
        self.store = store
        super.init(viewData: ViewData.initial)
        self.observeViewDataUpdate()
    }
    
    // MARK: - Private methods
    
    private func observeViewDataUpdate() {
        //Snippets LPM_1_1 - LPM_1_2
        let store = self.store
        let result = SignalProducer.combineLatest(store.model.producer,
                                                  self.emailError.producer,
                                                  self.passwordError.producer,
                                                  self.isShowPassword.producer,
                                                  self.isLoading.producer,
                                                  self.alertError.producer)
        result
            .take(during: self.lifetime)
            .startWithValues { [weak self] values in
                let (model, emailError, passwordError, isShowPassword, isLoading, alertError) = values
                self?.dataInternal.value = ViewData(login: model.email,
                                                    password: model.password,
                                                    emailError: emailError,
                                                    passwordError: passwordError,
                                                    isShowPassword: isShowPassword,
                                                    isLoading: isLoading,
                                                    alertError: alertError,
                                                    onLogin: { [weak self] in self?.login() },
                                                    onUpdatePassword: { [weak self] (text) in self?.update(password: text) },
                                                    onUpdateLogin: { [weak self] (text) in self?.update(email: text) },
                                                    back: { [weak self] in self?.back() },
                                                    resetPassword: { [weak self] in self?.resetPassword() },
                                                    doNotHaveAccount: { [weak self] in self?.doNotHaveAccount() },
                                                    onShowPassword: { [weak self] in self?.showPassword() })
        }
    }
    
    private func update(email: String) {
        //Snippet LPM_2_1
        self.store.update(email: email)
        self.emailError.value = nil
    }
    
    private func update(password: String) {
       //Snippet LPM_2_2
        self.store.update(password: password)
        self.passwordError.value = nil
    }
    
    private func login() {
        //Snippet LPM_3
        self.isLoading.value = true
        self.store.signInWithEmail()
            .observeOnMain()
            .take(during: self.lifetime)
            .startWithResult { [weak self] result in
                self?.isLoading.value = false
                switch result {
                case .success:
                    self?.actionEventEmitter.send(value: .loggedIn)
                case .failure(let error):
                    self?.update(error: error)
                }
        }
    }
    
    private func update(error: Error) {
        //Snippet LPM_4
        switch error {
        case .error(let reason):
            self.alertError.value = AlertError(title: nil,
                                               message: reason,
                                               actions: [AlertErrorAction(title: L10n.Localization.ok,
                                                                          style: .default,
                                                                          action: { [weak self] in self?.alertErrorAction() })])
            self.emailError.value = nil
            self.passwordError.value = nil
        case .invalidFields(let error):
            self.emailError.value = error.email
            self.passwordError.value = error.password
            self.alertError.value = nil
        }
    }
    
    private func alertErrorAction() {
        self.alertError.value = nil
    }
    
    private func resetPassword() {
        self.actionEventEmitter.send(value: .resetPassword)
    }
    
    private func doNotHaveAccount() {
        self.actionEventEmitter.send(value: .doNotHaveAccount)
    }
    
    private func showPassword() {
        self.isShowPassword.value = !self.isShowPassword.value
    }
    
    private func back() {
        self.store.clearPassword()
        self.actionEventEmitter.send(value: .back)
    }
}
