//
//  AuthenticationServiceLocator.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Services
import GoogleSignInProvider
import BackendServices

public protocol AuthenticationServiceLocator {
    
    var googleSignInProvider: GoogleSignInProvider { get }
    
    var googleUISignInProvider: GoogleUISignInProvider { get }
    
    var loginService: LoginService { get }
    
    var signUpService: SignUpService { get }
    
    var autoAuthenticationService: AutoAuthenticationService { get }
    
    func signInToAccountService() -> SignInToAccountService
    
    func resetPasswordBackendService() -> ResetPasswordBackendService
}
