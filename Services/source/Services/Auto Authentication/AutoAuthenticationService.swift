//
//  AutoAuthenticationService.swift
//  Services
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Models

//sourcery: AutoMockable
public protocol AutoAuthenticationService {
    
    func auth() -> SignalProducer<AuthResult, ServiceError>
    
}
