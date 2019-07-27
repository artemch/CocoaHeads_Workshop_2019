//
//  AutoAuthenticationBackendService.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Models

//sourcery: AutoMockable
public protocol AutoAuthenticationBackendService {
    
    func get() -> SignalProducer<Response.AutoAuthentication, BackendError>
    
}
