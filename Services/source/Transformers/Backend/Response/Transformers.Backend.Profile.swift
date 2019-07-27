//
//  Transformers.Backend.Profile.swift
//  Services
//
//  Created by Artem Chabannyi on 3/27/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import BackendServices

extension Transformers.BackendResponse {
    static func transform(profile: Response.Profile) -> Profile {
        return Profile(id: UserId(value: profile.id),
                       displayName: profile.displayName,
                       avatar: profile.avatar,
                       email: profile.email)
    }
}
