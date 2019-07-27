//
//  AuthenticationServiceLocatorImp.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import GoogleSignInProvider
import Services
import BackendServices

public class AuthenticationServiceLocatorImp: AuthenticationServiceLocator {
    
    public let googleSignInProvider: GoogleSignInProvider
    
    // MARK: - Private properties
    
    private let factoryLocator: FactoryLocator
    
    private let appServiceLocator: AppServiceLocator
    
    // MARK: - Initializations and Deallocations
    
    init(appServiceLocator: AppServiceLocator,
         factoryLocator: FactoryLocator)
    {
        self.appServiceLocator = appServiceLocator
        self.factoryLocator = factoryLocator
        self.googleSignInProvider = appServiceLocator.googleSignInProvider
    }
    
    // MARK: - Public methods
    
    public lazy var googleUISignInProvider: GoogleUISignInProvider = {
        return GoogleUISignInProvider()
    }()
    
    public lazy var loginService: LoginService = {
        return self.factoryLocator.servicesFactory.login(loginBackendService: self.factoryLocator.backendServiceFactory.login(),
                                                         googleSignInProvider: self.googleSignInProvider,
                                                         signInToAccountService: self.signInToAccountService())
    }()
    
    public lazy var signUpService: SignUpService = {
        return self.factoryLocator.servicesFactory.signUp(signUpBackendService: self.factoryLocator.backendServiceFactory.signUp(),
                                                          signInToAccountService: self.signInToAccountService())
    }()
    
    public func signInToAccountService() -> SignInToAccountService {
        return self.factoryLocator.servicesFactory.signInToAccountService(securityService: self.appServiceLocator.securityService,
                                                                          accountStorage: self.factoryLocator.storageFactory.accountStorage())
    }
    
    public lazy var autoAuthenticationService: AutoAuthenticationService = {
        return self.factoryLocator
            .servicesFactory
            .autoAuthentication(autoAuthenticationBackendService: self.factoryLocator.backendServiceFactory.autoAuthentication(),
                                signInToAccountService: self.signInToAccountService())
    }()
    
    public func resetPasswordBackendService() -> ResetPasswordBackendService {
        return self.factoryLocator.backendServiceFactory.resetPassword()
    }
}
