import Foundation
import ReactiveSwift
import Models
import Services
import Result

final public class AuthorizedStore: AuthorizedStoreProtocol {
    
    public let authUser: MutableProperty<AuthUser>
    
    // MARK: - Private properties
    
    private let (lifetime, token) = Lifetime.make()
    
    private let logOutService: LogOutService
    
    // MARK: - Initializations and Deallocations
    
    public init(authResult: AuthResult,
                logOutService: LogOutService)
    {
        self.authUser = MutableProperty(authResult.authUser)
        self.logOutService = logOutService
    }
    
    public func logOut() -> SignalProducer<Void, NoError> {
        return self.logOutService
            .logOut()
            .take(during: self.lifetime)
            .observeOnMain()
    }
}
