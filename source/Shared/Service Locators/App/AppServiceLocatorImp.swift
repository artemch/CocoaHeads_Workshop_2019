//
//  AppServiceLocatorImp.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Services
import BackendServices
import StorageServices
import GoogleSignInProvider

public class AppServiceLocatorImp: AppServiceLocator {
    
    public let googleSignInProvider: GoogleSignInProvider
    
    // MARK: - Private properties
    
    private let factoryLocator: FactoryLocator
    
    // MARK: - Initializations and Deallocations
    
    init(factoryLocator: FactoryLocator,
         googleSignInProvider: GoogleSignInProvider)
    {
        self.factoryLocator = factoryLocator
        self.googleSignInProvider = googleSignInProvider
    }
    
    // MARK: - Public methods
    
    public lazy var securityService: SecurityService = {
       return self.factoryLocator.servicesFactory.securityService(securityStorage: self.factoryLocator.storageFactory.securityStorage())
    }()
}
