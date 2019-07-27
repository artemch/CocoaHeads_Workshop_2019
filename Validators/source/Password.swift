//
//  Password.swift
//  Validators
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Result
import ReactiveSwift

public enum ChangePasswordError: Error {
    case invalidOldPassword
    case invalidNewPassword
    case invalidPasswords
    case passwordsShouldNotMatch
}

public func isPasswordValid(password: String) -> Bool {
    let regEx = "^.{\(Constants.minPasswordLength),}$"
    let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
    return predicate.evaluate(with: password)
}

public func isPasswordsValid(oldPassword: String, password: String) -> Result<Void, ChangePasswordError> {
    let isOldPassword = isPasswordValid(password: oldPassword)
    let isPassword = isPasswordValid(password: password)
    switch (isOldPassword, isPassword) {
    case (true, true):
        return  oldPassword != password ? .success(()) : .failure(.passwordsShouldNotMatch)
    case (false, false):
        return .failure(.invalidPasswords)
    case (true, false):
        return .failure(.invalidNewPassword)
    case (false, true):
        return .failure(.invalidOldPassword)
    }
}

public func isPasswordsValid(oldPassword: String, password: String) -> SignalProducer<Void, ChangePasswordError> {
    return SignalProducer { (observer, lifetime) in
        let isValid: Result<Void, ChangePasswordError> = isPasswordsValid(oldPassword: oldPassword, password: password)
        switch isValid {
        case .success:
            observer.send(value: ())
            observer.sendCompleted()
        case .failure(let error):
            observer.send(error: error)
        }
    }
}
