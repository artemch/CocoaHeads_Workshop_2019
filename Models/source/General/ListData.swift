

import Foundation

public enum ListData<T> {
    case loading
    case values([T])
    case error(String)
    
    public static var `default`: ListData<T> {
        return .values([])
    }
}

public extension ListData {
    var values: [T]? {
        switch self {
        case .values(let value):
            return value
        case .error, .loading:
            return nil
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .error, .values:
            return false
        }
    }
    
    var error: String? {
        switch self {
        case .error(let error):
            return error
        case .loading, .values:
            return nil
        }
    }
    
}
