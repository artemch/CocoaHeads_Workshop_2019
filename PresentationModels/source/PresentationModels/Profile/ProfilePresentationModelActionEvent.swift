import Foundation
import Models
import ReactiveSwift
import Result

public enum ProfileEventAction: EventActionType {
    case logOut
}

public protocol ProfilePresentationModelActionEvent {
    typealias EventAction = ProfileEventAction
    
    typealias EventSignalType = Signal<EventAction, NoError>
    
    var actionEvent: EventSignalType { get }
}

