//
//  ConcreteServicesFactory.swift
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

public class ConcreteServicesFactory: ServicesFactory {

    public func autoAuthentication(autoAuthenticationBackendService: AutoAuthenticationBackendService,
                                   signInToAccountService: SignInToAccountService) -> AutoAuthenticationService {
        return AutoAuthenticationServiceImp(autoAuthenticationBackendService: autoAuthenticationBackendService,
                                            signInToAccountService: signInToAccountService)
    }
    
    public func login(loginBackendService: LoginBackendService,
                      googleSignInProvider: GoogleSignInProvider,
                      signInToAccountService: SignInToAccountService) -> LoginService {
        return LoginServiceImp(loginBackendService: loginBackendService,
                               googleSignInProvider: googleSignInProvider,
                               signInToAccountService: signInToAccountService)
    }
    
    public func signUp(signUpBackendService: SignUpBackendService,
                       signInToAccountService: SignInToAccountService) -> SignUpService {
        return SignUpServiceImp(signUpBackendService: signUpBackendService,
                                signInToAccountService: signInToAccountService)
    }
    
    public func signInToAccountService(securityService: SecurityService,
                                       accountStorage: AccountStorage) -> SignInToAccountService {
        return SignInToAccountServiceImp(securityService: securityService,
                                         accountStorage: accountStorage)
    }
    
    public func securityService(securityStorage: SecurityStorage) -> SecurityService {
        return SecurityServiceImp(securityStorage: securityStorage)
    }
    
    public func logOutService(logOutBackendService: LogOutBackendService,
                              logOutStorage: LogOutStorage,
                              securityService: SecurityService,
                              socialServiceLogOutProvider: SocialServiceLogOutProvider) -> LogOutService {
        return LogOutServiceImp(logOutBackendService: logOutBackendService,
                                logOutStorage: logOutStorage,
                                securityService: securityService,
                                socialServiceLogOutProvider: socialServiceLogOutProvider)
    }
}

extension ConcreteServicesFactory {
    public static var `default`: ConcreteServicesFactory {
        return ConcreteServicesFactory()
    }
}
