//
//  ServicesFactory.swift
//  Services
//
//  Created by Artem Chabannyi on 2/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import StorageServices
import Models
import BackendServices
import GoogleSignInProvider

public protocol ServicesFactory {
    
    func autoAuthentication(autoAuthenticationBackendService: AutoAuthenticationBackendService,
                            signInToAccountService: SignInToAccountService) -> AutoAuthenticationService
    
    func login(loginBackendService: LoginBackendService,
               googleSignInProvider: GoogleSignInProvider,
               signInToAccountService: SignInToAccountService) -> LoginService
    
    func signUp(signUpBackendService: SignUpBackendService,
                signInToAccountService: SignInToAccountService) -> SignUpService
    
    func signInToAccountService(securityService: SecurityService,
                                accountStorage: AccountStorage) -> SignInToAccountService
    
    func securityService(securityStorage: SecurityStorage) -> SecurityService
    
    func logOutService(logOutBackendService: LogOutBackendService,
                       logOutStorage: LogOutStorage,
                       securityService: SecurityService,
                       socialServiceLogOutProvider: SocialServiceLogOutProvider) -> LogOutService
}
