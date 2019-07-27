import ReactiveSwift
import Models
import Result

//sourcery: AutoMockable
public protocol AuthorizedStoreProtocol: class {
    
    var authUser: MutableProperty<AuthUser> { get }

    func logOut() -> SignalProducer<Void, NoError>
    
}
