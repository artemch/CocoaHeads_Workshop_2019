//
//  Email.swift
//  Validators
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public enum EmailError: Error {
    case email
}

public func isValidEmail(email: String) -> Bool {
    let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
    return predicate.evaluate(with: email)
}

public func isValidEmail(email: String) -> SignalProducer<Void, EmailError> {
    return SignalProducer { (observer, lifetime) in
        let isValid: Bool = isValidEmail(email: email)
        if isValid {
            observer.send(value: ())
            observer.sendCompleted()
        } else {
            observer.send(error: .email)
        }
    }
}
