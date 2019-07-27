//
//  AutoAuthenticationServiceImp.swift
//  Services
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import BackendServices
import Models

public class AutoAuthenticationServiceImp: AutoAuthenticationService {
    
    private let autoAuthenticationBackendService: AutoAuthenticationBackendService
    
    private let signInToAccountService: SignInToAccountService
    
    // MARK: - Initializations and Deallocations
    
    init(autoAuthenticationBackendService: AutoAuthenticationBackendService,
         signInToAccountService: SignInToAccountService) {
        self.autoAuthenticationBackendService = autoAuthenticationBackendService
        self.signInToAccountService = signInToAccountService
    }
    
    // MARK: - Public methods
    
    public func auth() -> SignalProducer<AuthResult, ServiceError> {
        return self.autoAuthenticationBackendService
            .get()
            .mapError(Transformers.BackendError.transform)
            .map(Transformers.BackendResponse.transform)
            .flatMap(.latest, self.signInToAccountService.signInToAccount)
            .map { $0 }
    }
    
}
