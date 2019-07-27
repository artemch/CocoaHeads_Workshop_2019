import Foundation
import Models
import ReactiveSwift

//sourcery: AutoMockable
public protocol LoginBackendService {
    
    func post(credential: Request.LoginCredential) -> SignalProducer<Response.Login, BackendError>
    
}
