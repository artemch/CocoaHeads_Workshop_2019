//
//  Transformers.BackendResponse.Pagination.swift
//  Services
//
//  Created by Artem Chabannyi on 4/16/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import BackendServices

extension Transformers.BackendResponse {
    static func transform(value: Response.PaginationMeta) -> PaginationMeta {
        return PaginationMeta(totalCount: value.totalCount,
                              itemsCount: value.itemsCount,
                              limit: value.limit,
                              cursor: Transformers.BackendResponse.transform(value: value.cursor))
    }
    
    static func transform(value: Response.PaginationResultCursor) -> PaginationResultCursor {
        return PaginationResultCursor(up: value.up,
                                      down: value.down)
    }
}
