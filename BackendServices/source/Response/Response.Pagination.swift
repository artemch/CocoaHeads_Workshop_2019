//
//  Response.Pagination.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 4/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models

public extension Response {
    struct Pagination<T: Decodable>: Decodable {
        public let meta: PaginationMeta
        public let data: [T]
    }
    
    struct PaginationMeta: Decodable {
        public let totalCount: Int
        public let itemsCount: Int
        public let limit: Int
        public let cursor: PaginationResultCursor
    }
    
    struct PaginationResultCursor: Decodable {
        public let up: PaginationCursor
        public let down: PaginationCursor
    }
}

extension Response.Pagination {
    enum CodingKeys: String, CodingKey {
        case meta
        case data
    }
}

extension Response.PaginationMeta {
    enum CodingKeys: String, CodingKey {
        case totalCount
        case itemsCount
        case limit
        case cursor
    }
}

extension Response.PaginationResultCursor {
    enum CodingKeys: String, CodingKey {
        case up
        case down
    }
}

public extension Response.Pagination {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode([T].self, forKey: .data)
        meta = try values.decode(Response.PaginationMeta.self, forKey: .meta)
    }
}

public extension Response.PaginationMeta {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try values.decode(Int.self, forKey: .totalCount)
        itemsCount = try values.decode(Int.self, forKey: .itemsCount)
        limit = try values.decode(Int.self, forKey: .limit)
        cursor = try values.decode(Response.PaginationResultCursor.self, forKey: .cursor)
    }
}

public extension Response.PaginationResultCursor {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        up = try values.decodeIfPresent(String.self, forKey: .up).map { .cursor($0) } ?? .none
        down = try values.decodeIfPresent(String.self, forKey: .down).map { .cursor($0) } ?? .none
    }
}
