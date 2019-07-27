//
//  AutoAuthenticationBackendServiceImp.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import ReactiveSwift
import Alamofire
import AlamofireReactive
import ReactiveSwiftKit

public class AutoAuthenticationBackendServiceImp: AuthorizedBackendService, AutoAuthenticationBackendService {
    
    let accessTokenProvider: AccessTokenProvider
    
    // MARK: - Initializations and Deallocations
    
    init(sessionManager: SessionManager,
         pathBuilder: URLPathBuilder,
         accessTokenProvider: AccessTokenProvider)
    {
        self.accessTokenProvider = accessTokenProvider
        super.init(sessionManager: sessionManager,
                   pathBuilder: pathBuilder,
                   tokenProvider: accessTokenProvider)
    }
    
    // MARK: - Public methods
    
    public func get() -> SignalProducer<Response.AutoAuthentication, BackendError> {
        return self.accessTokenProvider.retriveAccessToken()
            .delay(0.5, on: QueueScheduler(name: "com.idap.workshop"))
            .flatMap(.latest) { token in
                if let _ = token {
                   return F.jsonMock(fileName: "auto_login")
                } else {
                    return SignalProducer(error: .noToken)
                }
        }
    }
}
