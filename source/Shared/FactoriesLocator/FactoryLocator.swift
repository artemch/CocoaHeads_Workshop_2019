//
//  FactoryLocator.swift
//  Services
//
//  Created by Artem Chabannyi on 2/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import StorageServices
import Services
import BackendServices

public class FactoryLocator {
    
    public let appConfigFactory: AppConfigFactory
    
    public let storageFactory: StorageFactory
    
    public let servicesFactory: ServicesFactory
    
    public let backendServiceFactory: BackendServiceFactory
    
    public init(appConfigFactory: AppConfigFactory,
                storageFactory: StorageFactory,
                servicesFactory: ServicesFactory,
                backendServiceFactory: BackendServiceFactory) {
        self.appConfigFactory = appConfigFactory
        self.storageFactory = storageFactory
        self.servicesFactory = servicesFactory
        self.backendServiceFactory = backendServiceFactory
    }
    
}

extension FactoryLocator {
    public static func `default`() -> FactoryLocator {
        let appConfigFactory = AppConfigFactory()
        let appConfig = appConfigFactory.defaultAppConfig
        let storageFactory = RealmStorageFactory.default(securityStoreName: appConfig.securityStoreName, storageName: appConfig.storageName)
        let tokenProvider = StorageAccessTokenProvider(securityStorage: storageFactory.securityStorage())
        let servicesFactory = ConcreteServicesFactory.default
        let backendServiceFactory = BackendServiceFactoryImp(host: appConfig.host,
                                                             accessTokenProvider: tokenProvider)
        return FactoryLocator(appConfigFactory: appConfigFactory,
                              storageFactory: storageFactory,
                              servicesFactory: servicesFactory,
                              backendServiceFactory: backendServiceFactory)
    }
}
