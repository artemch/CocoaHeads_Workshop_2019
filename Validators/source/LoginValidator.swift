//
//  LoginValidator.swift
//  Validators
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Result
import ReactiveSwift

public enum LoginValidationError: Error {
    case email
    case password
    case emailAndPassword
}

public func loginValidation(email: String, password: String) -> Result<Void, LoginValidationError> {
    let isEmail: Bool = isValidEmail(email: email)
    let isPassword = isPasswordValid(password: password)
    switch (isEmail, isPassword) {
    case (true, true):
        return .success(())
    case (true, false):
        return .failure(.password)
    case (false, true):
        return .failure(.email)
    case (false, false):
        return .failure(.emailAndPassword)
    }
}

public func loginValidation(email: String, password: String) -> SignalProducer<Void, LoginValidationError> {
    return SignalProducer { (observer, lifetime) in
        let result: Result<Void, LoginValidationError> = loginValidation(email: email, password: password)
        switch result {
        case .success(_):
            observer.send(value: ())
            observer.sendCompleted()
        case .failure(let error):
            observer.send(error: error)
        }
    }
}
