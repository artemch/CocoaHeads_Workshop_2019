//
//  AuthResult.swift
//  Models
//
//  Created by Artem Chabannyi on 3/18/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public struct AuthResult {
    public let authUser: AuthUser
    public let token: AccessToken
    public let isAfterRegistration: Bool
    
    public init(authUser: AuthUser,
                token: AccessToken,
                isAfterRegistration: Bool) {
        self.authUser = authUser
        self.token = token
        self.isAfterRegistration = isAfterRegistration
    }
}
