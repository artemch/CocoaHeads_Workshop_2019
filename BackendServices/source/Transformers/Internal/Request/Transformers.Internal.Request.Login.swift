//
//  TransformersRequest+Login.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/13/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

extension Transformers.Request {
    static func transformLoginWithGoogle(userIdToken: String) -> Request.LoginWithGoogle {
        return Request.LoginWithGoogle(userIdToken: userIdToken)
    }
    
    static func transformLoginWithEmail(email: String, password: String) -> Request.LoginWithEmail {
        return Request.LoginWithEmail(email: email, password: password)
    }
}
