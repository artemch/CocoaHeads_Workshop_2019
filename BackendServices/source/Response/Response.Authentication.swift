//
//  Response+Authentication.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public extension Response {
    struct Authentication: Decodable {
        public struct Auth: Decodable {
            public let provider: String
            public let token: String
            public let isRegistered: Bool
        }
        
        public struct Account: Decodable {
            public let id: Int
            public let displayName: String
            public let avatar: String
            public let email: String
        }
        
        public let auth: Auth
        public let account: Account
    }
}

public extension Response {
    typealias AutoAuthentication = Authentication
}

public extension Response {
    typealias Login = Authentication
}

public extension Response {
    typealias SignUp = Authentication
}
