import Foundation

public enum LoadingState<Error: Swift.Error> {
    case none
    case loading
    case error(Error)
    
    public static var `default`: LoadingState {
        return .none
    }
    
    public var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .error, .none:
            return false
        }
    }
}
