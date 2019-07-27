//
//  LoginWithGoogleBackendServiceImp.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire
import AlamofireReactive

class LoginWithGoogleBackendServiceImp: BaseBackendService, LoginWithGoogleBackendService {
    
    // MARK: - Public methods
    
    func post(credential: Request.LoginWithGoogle) -> SignalProducer<Response.Login, BackendError> {
        let url = self.pathBuilder.append(component: "accounts/login/google").build()
        return F.post(sessionManager: self.sessionManager, url: url,
                      parameters: self.parameters(credential: credential))
    }
    
}

fileprivate extension LoginWithGoogleBackendServiceImp {
    enum ParametersKeys: String {
        case tokenId
    }
    
    func parameters(credential: Request.LoginWithGoogle) -> [String: Any] {
        return [ParametersKeys.tokenId.rawValue: credential.userIdToken]
    }
}
