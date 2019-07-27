//
//  SecurityServiceImp.swift
//  Services
//
//  Created by Artem Chabannyi on 2/21/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import StorageServices
import ReactiveSwift
import Models

public class SecurityServiceImp: SecurityService {
    
    private let securityStorage: SecurityStorage
    
    // MARK: - Initializations and Deallocations
    
    init(securityStorage: SecurityStorage) {
        self.securityStorage = securityStorage
    }
    
    
    public func saveAuthUserToken(token: AccessToken) -> SignalProducer<AccessToken, ServiceError> {
        return SignalProducer { (observer, lifetime) in
            self.securityStorage.saveAuthUserToken(token: token)
            observer.send(value: token)
            observer.sendCompleted()
        }
    }
    
    public func retriveAuthUserToken() -> SignalProducer<AccessToken?, ServiceError> {
        return SignalProducer { (observer, lifetime) in
            let token = self.securityStorage.retriveAuthUserToken()
            observer.send(value: token)
            observer.sendCompleted()
        }
    }
    
    public func removeUserAuthToken() -> SignalProducer<Void, ServiceError> {
        return SignalProducer { (observer, lifetime) in
            self.securityStorage.removeUserAuthToken()
            observer.send(value: ())
            observer.sendCompleted()
        }
    }
}
