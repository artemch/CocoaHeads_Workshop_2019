//
//  Request+Login.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/13/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public extension Request {
    
    enum LoginCredential {
        case email(email: String, password: String)
        case google(userIdToken: String)
    }
    
}

public extension Request {
    
    enum SignUpCredential {
        case email(email: String, password: String, displayName: String?)
    }
    
}

public extension Request {
    struct ResetPassword: Equatable {
        public let email: String
        
        public init(email: String) {
            self.email = email
        }
    }
}

internal extension Request {
    struct LoginWithEmail {
        let email: String
        let password: String
    }
    
    struct LoginWithGoogle {
        let userIdToken: String
    }
}
