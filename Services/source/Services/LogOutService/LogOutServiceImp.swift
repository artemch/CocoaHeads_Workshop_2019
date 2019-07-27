//
//  LogOutServiceImp.swift
//  Services
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import BackendServices
import StorageServices
import Result



public class LogOutServiceImp: LogOutService {
    
    let logOutBackendService: LogOutBackendService
    
    let logOutStorage: LogOutStorage
    
    let securityService: SecurityService
    
    let socialServiceLogOutProvider: SocialServiceLogOutProvider
    
    // MARK: - Initializations and Deallocations
    
    init(logOutBackendService: LogOutBackendService,
         logOutStorage: LogOutStorage,
         securityService: SecurityService,
         socialServiceLogOutProvider: SocialServiceLogOutProvider)
    {
        self.logOutBackendService = logOutBackendService
        self.logOutStorage = logOutStorage
        self.securityService = securityService
        self.socialServiceLogOutProvider = socialServiceLogOutProvider
    }
    
    // MARK: - Public methods
    
    public func logOut() -> SignalProducer<(), NoError> {
        return self.logOutBackendService.logOut()
            .flatMapError { _ in SignalProducer(value: ()) }
            .map { _ in () }
            .flatMap(.latest) { _ in self.logOutStorage.logOut() }
            .flatMap(.latest) { _ in self.socialServiceLogOutProvider.logOut() }
            .flatMap(.latest) { _ in self.securityService.removeUserAuthToken().flatMapError { _ in SignalProducer<Void, NoError>(value: ()) } }
    }
}
