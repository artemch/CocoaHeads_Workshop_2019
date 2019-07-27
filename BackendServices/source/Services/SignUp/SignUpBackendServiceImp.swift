//
//  SignUpBackendServiceImp.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveSwiftKit
import FoundationKit

public class SignUpBackendServiceImp: BaseBackendService, SignUpBackendService {
    
    // MARK: - Public methods
    
    public func post(credential: Request.SignUpCredential) -> SignalProducer<Response.SignUp, BackendError> {
        return F.jsonMock(fileName: "sign_up")
    }
    
}

fileprivate extension SignUpBackendServiceImp {
    enum ParametersKey: String {
        case email
        case password
        case displayName
    }
    
    func parameters(credential: Request.SignUpCredential) -> [String: Any] {
        switch credential {
        case .email(let email, let password, let displayName):
            var parameters = [ParametersKey.email.rawValue: email,
                              ParametersKey.password.rawValue: password]
            displayName.do {
                parameters[ParametersKey.displayName.rawValue] = $0
            }
            return parameters
        }
        
    }
}
