//
//  F+Pagination.swift
//  PresentationModels
//
//  Created by Artem Chabannyi on 5/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models

extension F {
    static func transform(value: PaginationState) -> PaginationListViewDataState {
        switch value {
        case .failed:
            return .none
        case .state(let state):
            return F.transform(value: state)
        }
    }
}

extension F {
    static func transform(value: PaginationLoadingState) -> PaginationListViewDataState {
        switch value {
        case .none:
            return .none
        case .loading:
            return .reloading
        case .loadingNext:
            return .loadingMore
        }
    }
}
