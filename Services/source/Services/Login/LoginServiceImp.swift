import Foundation
import Models
import ReactiveSwift
import BackendServices
import GoogleSignInProvider
import Result

public class LoginServiceImp: LoginService {
    
    let loginBackendService: LoginBackendService
    
    let googleSignInProvider: GoogleSignInProviderProtocol
    
    let signInToAccountService: SignInToAccountService
    
    // MARK: - Initializations and Deallocations
    
    init(loginBackendService: LoginBackendService,
         googleSignInProvider: GoogleSignInProviderProtocol,
         signInToAccountService: SignInToAccountService) {
        self.loginBackendService = loginBackendService
        self.googleSignInProvider = googleSignInProvider
        self.signInToAccountService = signInToAccountService
    }
    
    // MARK: - Public methods
    
    public func login(credential: LoginCredential) -> SignalProducer<AuthResult, ServiceError> {
        //Snippets LS_1_1 - 1_2
        var signalProducer: SignalProducer<BackendServices.Request.LoginCredential, ServiceError>
        
        switch credential {
        case .google:
            signalProducer = self.googleSignInProvider.signIn()
                .flatMap(FlattenStrategy.latest, LoginServiceImp.F.transformGoogleProviderResponse)
        case .email(let email, let password):
            signalProducer = SignalProducer(value: BackendServices.Transformers.Request.transformLoginWithEmail(email: email, password: password))
            
        }
        let googleSignInProvider = self.googleSignInProvider
        return signalProducer.flatMap(FlattenStrategy.latest) { rCredential in
            self.loginBackendService
                .post(credential: rCredential)
                .map(Transformers.BackendResponse.transform)
                .flatMapError { error in googleSignInProvider.signOut().flatMap(.latest) { _ in SignalProducer(error: error) } }
                .mapError(Transformers.BackendError.transform)
                .flatMap(.latest, self.signInToAccountService.signInToAccount)
        }
    }
}

extension LoginServiceImp {
    enum F {
        static func transformGoogleProviderResponse(response: GoogleSignInResult) -> SignalProducer<BackendServices.Request.LoginCredential, ServiceError>
        {
            switch response {
            case .success(let googleUser):
                return SignalProducer(value: BackendServices.Transformers.Request
                    .transformLoginWithGoogle(userIdToken: googleUser.idToken))
                    .mapError(Transformers.Error.transformNSError)
            case .failure(let error):
                return SignalProducer(error: Transformers.Error.transformGoogleSignInError(error: error))
            }
        }
    }
}
