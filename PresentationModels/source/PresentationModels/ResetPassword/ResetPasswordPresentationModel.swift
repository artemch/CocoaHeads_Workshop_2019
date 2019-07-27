import Foundation
import ReactiveSwift
import Result

public struct ResetPasswordViewData {
    
    public enum ResetState {
        case notReset(command: (() -> ())?)
        case reset(command: (() -> ())?)
        case inProgress
        
        public var isReset: Bool {
            if case .reset(_) = self { return true } else { return false }
        }
    }
    
    public let email: String
    public let state: ResetState
    public let emailError: String?
    public let onUpdateEmail: ((String) -> ())?
    public let onBack: (() -> ())?
    
    static var initial: ResetPasswordViewData {
        return ResetPasswordViewData(email: "",
                                     state: .notReset(command: nil),
                                     emailError: nil,
                                     onUpdateEmail: nil,
                                     onBack: nil)
    }
}

public protocol ResetPasswordPresentationModel: PresentationModel where ViewData == ResetPasswordViewData {
    
}
