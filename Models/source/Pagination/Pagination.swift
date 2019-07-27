
import Foundation

public enum PaginationMode: String, Equatable {
    case down
}

public enum PaginationCursor: Equatable {
    case none
    case cursor(String)
    
    public var cursor: String? {
        switch self {
        case .none:
            return nil
        case .cursor(let value):
            return value
        }
    }
}

public struct Pagination: Equatable {
    public let limit: UInt
    public let cursor: PaginationCursor
    public let mode: PaginationMode
    
    public init(limit: UInt,
                cursor: PaginationCursor,
                mode: PaginationMode) {
        self.limit = limit
        self.cursor = cursor
        self.mode = mode
    }
}

public struct PaginationResult<T> {
    public let data: [T]
    public let meta: PaginationMeta
    
    public init(data: [T],
                meta: PaginationMeta) {
        self.data = data
        self.meta = meta
    }
}

public struct PaginationMeta: Equatable {
    public let totalCount: Int
    public let itemsCount: Int
    public let limit: Int
    public let cursor: PaginationResultCursor
    
    public init(totalCount: Int,
                itemsCount: Int,
                limit: Int,
                cursor: PaginationResultCursor) {
        self.totalCount = totalCount
        self.itemsCount = itemsCount
        self.limit = limit
        self.cursor = cursor
    }
    
    //Default value of limit = 7
    public static var `default`: PaginationMeta {
        return PaginationMeta(totalCount: 0,
                              itemsCount: 0,
                              limit: 7,
                              cursor: .default)
    }
}

public struct PaginationResultCursor: Equatable {
    public let up: PaginationCursor
    public let down: PaginationCursor
    
    public init(up: PaginationCursor,
                down: PaginationCursor) {
        self.up = up
        self.down = down
    }
    
    public static var `default`: PaginationResultCursor {
        return PaginationResultCursor(up: .none,
                                      down: .none)
    }
}

public extension PaginationMeta {
    func updateTotalCount(_ totalCount: Int) -> PaginationMeta {
        return PaginationMeta(totalCount: totalCount,
                              itemsCount: self.itemsCount,
                              limit: self.limit,
                              cursor: self.cursor)
    }
    
    func updateLimit(_ limit: Int) -> PaginationMeta {
        return PaginationMeta(totalCount: self.totalCount,
                              itemsCount: self.itemsCount,
                              limit: limit,
                              cursor: self.cursor)
    }
}
