//
//  PaginationListViewData.swift
//  PresentationModels
//
//  Created by Artem Chabannyi on 5/21/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public struct PaginationListViewData<Value> {
    public let values: [Value]
    public let state: PaginationListViewDataState
    public let onReload: (() -> ())?
    public let onLoadMore: (() -> ())?
    
    static var initial: PaginationListViewData<Value> {
        return PaginationListViewData(values: [],
                                      state: .none,
                                      onReload: nil,
                                      onLoadMore: nil)
    }
}

public enum PaginationListViewDataState {
    case none
    case reloading
    case loadingMore
}
public extension PaginationListViewData {
    var isLoading: Bool {
        switch self.state {
        case .none:
            return false
        case .reloading, .loadingMore:
            return true
        }
    }
    
    var isReloading: Bool {
        switch self.state {
        case .none, .loadingMore:
            return false
        case .reloading:
            return true
        }
    }
    
    var isLoadingMore: Bool {
        switch self.state {
        case .none, .reloading:
            return false
        case .loadingMore:
            return true
        }
    }
}
