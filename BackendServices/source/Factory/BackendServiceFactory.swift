//
//  BackendServiceFactory.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/10/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public protocol BackendServiceFactory {
    
    func autoAuthentication() -> AutoAuthenticationBackendService
    
    func login() -> LoginBackendService
    
    func logOut() -> LogOutBackendService
    
    func signUp() -> SignUpBackendService
    
    func resetPassword() -> ResetPasswordBackendService
}
