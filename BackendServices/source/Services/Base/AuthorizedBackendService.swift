//
//  AuthorizedBackendService.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/22/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Alamofire

public class AuthorizedBackendService: BaseBackendService {
    
    let tokenProvider: AccessTokenProvider
    
    // MARK: - Initializations and Deallocations
    
    init(sessionManager: SessionManager,
         pathBuilder: URLPathBuilder,
         tokenProvider: AccessTokenProvider)
    {
        self.tokenProvider = tokenProvider
        super.init(sessionManager: sessionManager, pathBuilder: pathBuilder)
    }
}
