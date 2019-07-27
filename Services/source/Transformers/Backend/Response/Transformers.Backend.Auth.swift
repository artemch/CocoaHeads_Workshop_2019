//
//  Transformers.Backend.Auth.swift
//  Services
//
//  Created by Artem Chabannyi on 3/18/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import BackendServices

extension Transformers.BackendResponse {
    static func transform(value: Response.Authentication) -> AuthResult {
        let authUser = AuthUser(profile: Profile(id: UserId(value: value.account.id),
                                                 displayName: value.account.displayName,
                                                 avatar: value.account.avatar,
                                                 email: value.account.email),
                                provider: Models.Transformers.LoginProvider.transform(provider: value.auth.provider))
        return AuthResult(authUser: authUser, token: value.auth.token, isAfterRegistration: !value.auth.isRegistered)
    }
}
