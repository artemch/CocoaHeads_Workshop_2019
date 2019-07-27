//
//  PaginationListData.swift
//  Models
//
//  Created by Artem Chabannyi on 4/17/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public enum PaginationState: Equatable {
    case state(PaginationLoadingState)
    case failed(String, state: PaginationLoadingState)
    
    public var state: PaginationLoadingState {
        switch self {
        case .state(let state):
            return state
        case .failed(_, let state):
            return state
        }
    }
    
    public var isFailed: Bool {
        switch self {
        case .state:
            return false
        case .failed:
            return true
        }
    }
    
    public var isLoading: Bool {
        switch self {
        case .state(let state):
            return state.isLoading
        case .failed:
            return false
        }
    }
    
    public var isLoadingNext: Bool {
        switch self {
        case .state(let state):
            return state.isLoadingNext
        case .failed:
            return false
        }
    }
    
    public var isReloading: Bool {
        switch self {
        case .state(let state):
            return state.isReloading
        case .failed:
            return false
        }
    }
}

public enum PaginationLoadingState: Equatable {
    case none
    case loading
    case loadingNext
    
    public var isLoading: Bool {
        switch self {
        case .none:
            return false
        case .loading, .loadingNext:
            return true
        }
    }
    
    public var isReloading: Bool {
        switch self {
        case .none, .loadingNext:
            return false
        case .loading:
            return true
        }
    }
    
    public var isLoadingNext: Bool {
        switch self {
        case .none, .loading:
            return false
        case .loadingNext:
            return true
        }
    }
}

public struct PaginationListData<T: Equatable>: Equatable {
    public let data: [T]
    public let state: PaginationState
    public let meta: PaginationMeta
    
    public init(data: [T],
                state: PaginationState,
                meta: PaginationMeta) {
        self.data = data
        self.state = state
        self.meta = meta
    }
}

public extension PaginationState {
    static var none: PaginationState {
        return .state(.none)
    }
    
    static var loading: PaginationState {
        return .state(.loading)
    }
    
    static var loadingNext: PaginationState {
        return .state(.loadingNext)
    }
    
    func failed(error: String) -> PaginationState {
        return .failed(error, state: self.state)
    }
}

public extension PaginationListData {
    static var empty: PaginationListData<T> {
        return PaginationListData(data: [], state: .none, meta: .default)
    }
}

public extension PaginationListData {
    var totalCount: Int {
        return self.meta.totalCount
    }
}

public extension PaginationListData {
    func update(state: PaginationState) -> PaginationListData<T> {
        return self.update(data: self.data, state: state, meta: self.meta)
    }
    
    func update(data: [T], state: PaginationState? = nil, meta: PaginationMeta) -> PaginationListData<T> {
        return PaginationListData(data: data, state: state ?? self.state, meta: meta)
    }
    
    func append(data: [T], state: PaginationState? = nil, meta: PaginationMeta) -> PaginationListData<T> {
        return PaginationListData(data: self.data + data, state: state ?? self.state, meta: meta)
    }
    
    func update(data: [T], state: PaginationState? = nil, totalCount: Int) -> PaginationListData<T> {
        return self.update(data: data, state: state, meta: self.meta.updateTotalCount(totalCount))
    }
    
    func decrease(count: Int) -> PaginationListData<T> {
        return PaginationListData(data: self.data,
                                  state: self.state,
                                  meta: self.meta.updateTotalCount(max(0, self.meta.totalCount - count)))
    }
}
