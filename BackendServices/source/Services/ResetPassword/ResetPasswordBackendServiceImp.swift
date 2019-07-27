//
//  ResetPasswordBackendServiceImp.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/22/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public class ResetPasswordBackendServiceImp: BaseBackendService, ResetPasswordBackendService {
    
    // MARK: - Public methods
    
    public  func post(request: Request.ResetPassword) -> SignalProducer<Void, BackendError> {
        return SignalProducer(value: ())
    }
    
}

fileprivate extension ResetPasswordBackendServiceImp {
    enum ParametersKey: String {
        case email
    }
    
    func parameters(request: Request.ResetPassword) -> [String: Any] {
        return [ParametersKey.email.rawValue: request.email]
    }
}
