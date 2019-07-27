//
//  BaseBackendService.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire
import AlamofireReactive

public class BaseBackendService {
    
    let sessionManager: SessionManager
    
    let pathBuilder: URLPathBuilder
    
    // MARK: - Initializations and Deallocations
    
    init(sessionManager: SessionManager,
         pathBuilder: URLPathBuilder)
    {
        self.sessionManager = sessionManager
        self.pathBuilder = pathBuilder
    }
}
