//
//  SignUpService.swift
//  Services
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import ReactiveSwift

//sourcery: AutoMockable
public protocol SignUpService {
    
    func signUp(credential: SignUpCredential) -> SignalProducer<AuthResult, ServiceError>
    
}
