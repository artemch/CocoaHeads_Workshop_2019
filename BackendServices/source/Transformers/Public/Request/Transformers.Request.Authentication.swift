//
//  Transformers.Request+Login.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models

public extension Transformers.Request {
    static func transformLoginWithGoogle(userIdToken: String) -> Request.LoginCredential {
        return .google(userIdToken: userIdToken)
    }
    
    static func transformLoginWithEmail(email: String, password: String) -> Request.LoginCredential {
        return .email(email: email, password: password)
    }
    
    static func transformSignUpWithEmail(email: String, password: String, displayName: String?) -> Request.SignUpCredential {
        return .email(email: email, password: password, displayName: displayName)
    }
}
