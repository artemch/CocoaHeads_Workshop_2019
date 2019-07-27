//
//  SignUpBackendService.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

//sourcery: AutoMockable
public protocol SignUpBackendService {
    
    func post(credential: Request.SignUpCredential) -> SignalProducer<Response.SignUp, BackendError>
    
}
