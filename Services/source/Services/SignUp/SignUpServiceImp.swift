//
//  SignUpServiceImp.swift
//  Services
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import ReactiveSwift
import BackendServices
import GoogleSignInProvider
import Result
import StorageServices

public class SignUpServiceImp: SignUpService {
    
    let signUpBackendService: SignUpBackendService
    
    let signInToAccountService: SignInToAccountService
    
    // MARK: - Initializations and Deallocations
    
    init(signUpBackendService: SignUpBackendService,
         signInToAccountService: SignInToAccountService) {
        self.signUpBackendService = signUpBackendService
        self.signInToAccountService = signInToAccountService
    }
    
    // MARK: - Public methods
    
    public func signUp(credential: SignUpCredential) -> SignalProducer<AuthResult, ServiceError> {
        
        var signalProducer: SignalProducer<BackendServices.Request.SignUpCredential, ServiceError>
        
        switch credential {
        case .email(let email, let password, let displayName):
            signalProducer = SignalProducer(value: BackendServices.Transformers
                .Request
                .transformSignUpWithEmail(email: email, password: password, displayName: displayName))
        }
        
        return signalProducer.flatMap(FlattenStrategy.latest) { rCredential in
            self.signUpBackendService
                .post(credential: rCredential).map(Transformers.BackendResponse.transform)
                .mapError(Transformers.BackendError.transform)
                .flatMap(.latest, self.signInToAccountService.signInToAccount)
        }
    }
}
