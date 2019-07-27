import Foundation
import ReactiveSwift
import ReactiveSwiftKit
import Stores
import Models

public class ProfilePresentationModelImp: ProfilePresentationModel, ProfilePresentationModelActionEvent {
    
    public var actionEvent: EventSignalType {
        return self.actionEventEmitter.event
    }
    
    public let data: Property<ViewData>
    
    let dataInternal: MutableProperty<ViewData>
    
    let (lifetime, token) = Lifetime.make()
    
    // MARK: - Private properties
    
    private let actionEventEmitter = EventEmitter<EventSignalType.Value>()
    
    private let store: AuthorizedStoreProtocol
    
    // MARK: - Initializations and Deallocations
    
    public init(store: AuthorizedStoreProtocol) {
        self.store = store
        let dataInternal = MutableProperty(ViewData.initial)
        self.dataInternal = dataInternal
        self.data = Property(capturing: dataInternal)
        self.updateViewData()
    }
    
    // MARK: - Private methods
    
    private func updateViewData() {
        self.dataInternal.value = ViewData(onLogOut: { [weak self] in self?.logOut() })
    }
    
    private func logOut() {
        self.store
            .logOut()
            .take(during: self.lifetime)
            .startWithResult { [weak self] result in
                self?.actionEventEmitter.send(value: .logOut)
        }
    }
    
}
