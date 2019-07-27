//
//  Response.Profile.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 3/27/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public extension Response {
    struct Profile: Decodable {
        public let id: Int
        public let displayName: String?
        public let avatar: String
        public let email: String
    }
}
