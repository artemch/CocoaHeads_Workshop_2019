//
//  SecurityService.swift
//  Services
//
//  Created by Artem Chabannyi on 2/21/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Models

//sourcery: AutoMockable
public protocol SecurityService {
    
    func saveAuthUserToken(token: AccessToken) -> SignalProducer<AccessToken, ServiceError>
    
    func retriveAuthUserToken() -> SignalProducer<AccessToken?, ServiceError>
    
    func removeUserAuthToken() -> SignalProducer<Void, ServiceError>
    
}
