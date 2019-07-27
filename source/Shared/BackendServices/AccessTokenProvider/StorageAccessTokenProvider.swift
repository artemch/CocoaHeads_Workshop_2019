//
//  StorageAccessTokenProvider.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import BackendServices
import ReactiveSwift
import StorageServices
import Result
import Models

public class StorageAccessTokenProvider: AccessTokenProvider {
    
    private let securityStorage: SecurityStorage
    
    public init(securityStorage: SecurityStorage) {
        self.securityStorage = securityStorage
    }
    
    public func retriveAccessToken() -> SignalProducer<AccessToken?, NoError> {
        return SignalProducer { (observer, lifetime) in
            let token = self.securityStorage.retriveAuthUserToken()
            observer.send(value: token)
            observer.sendCompleted()
        }
    }
    
}
