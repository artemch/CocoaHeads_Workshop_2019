import Foundation
import Models
import ReactiveSwift
import BackendServices

//sourcery: AutoMockable
public protocol LoginService {
    
    func login(credential: LoginCredential) -> SignalProducer<AuthResult, ServiceError>
    
}
