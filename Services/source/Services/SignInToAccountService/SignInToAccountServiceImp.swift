//
//  SignInToAccountServiceImp.swift
//  Services
//
//  Created by Artem Chabannyi on 2/21/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import StorageServices
import Models
import ReactiveSwift

public class SignInToAccountServiceImp: SignInToAccountService {
    
    let securityService: SecurityService
    
    let accountStorage: AccountStorage
    
    // MARK: - Initializations and Deallocations
    
    init(securityService: SecurityService,
         accountStorage: AccountStorage) {
        self.securityService = securityService
        self.accountStorage = accountStorage
    }
    
    // MARK: - Public methods
    
    public func signInToAccount(authResult: AuthResult) -> SignalProducer<AuthResult, ServiceError> {
        return self.securityService.saveAuthUserToken(token: authResult.token)
            .map { _ in authResult }
            .flatMap(.latest) { self.accountStorage.writeAuthUser(model: $0.authUser).mapError(Transformers.StorageError.transform) }
            .map { _ in authResult }
    }
}
