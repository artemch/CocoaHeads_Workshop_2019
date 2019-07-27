//
//  ResetPasswordBackendService.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/22/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

//sourcery: AutoMockable
public protocol ResetPasswordBackendService {
    
    func post(request: Request.ResetPassword) -> SignalProducer<Void, BackendError>
    
}
