import Foundation
import Models
import ReactiveSwift
import Result

public enum EventActionLoginWithEmail: EventActionType {
    case back
    case loggedIn
    case resetPassword
    case doNotHaveAccount
}

public protocol LoginWithEmailPresentationModelActionEvent {
    typealias EventAction = EventActionLoginWithEmail
    
    typealias EventSignalType = Signal<EventAction, NoError>
    
    var actionEvent: EventSignalType { get }
}
