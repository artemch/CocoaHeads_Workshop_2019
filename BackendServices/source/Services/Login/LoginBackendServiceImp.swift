import Foundation
import ReactiveSwift

public class LoginBackendServiceImp: LoginBackendService {
    
    private let email: LoginWithEmailBackendService
    
    private let google: LoginWithGoogleBackendService
    
    // MARK: - Initializations and Deallocations
    
    init(email: LoginWithEmailBackendService,
         google: LoginWithGoogleBackendService)
    {
        self.email = email
        self.google = google
    }
    
    // MARK: - Public methods
    
    public func post(credential: Request.LoginCredential) -> SignalProducer<Response.Login, BackendError> {
        switch credential {
        case .email(let email, let password):
            return self.email.post(credential: Transformers.Request.transformLoginWithEmail(email: email, password: password))
        case .google(let userIdToken):
            return self.google.post(credential: Transformers.Request.transformLoginWithGoogle(userIdToken: userIdToken))
        }
    }
}


