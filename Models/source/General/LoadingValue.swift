import Foundation

public enum LoadingValue<Value, Error: Swift.Error> {
    case empty
    case value(Value)
    case loading
    case error(Error)
}

public extension LoadingValue {
    
    var value: Value? {
        switch self {
        case .value(let value):
            return value
        case .empty, .error, .loading:
            return nil
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .empty, .error, .value:
            return false
        }
    }
    
    var error: Error? {
        switch self {
        case .error(let error):
            return error
        case .empty, .value, .loading:
            return nil
        }
    }
    
    var isEmpty: Bool {
        switch self {
        case .empty:
            return true
        case .loading, .error, .value:
            return false
        }
    }
}
