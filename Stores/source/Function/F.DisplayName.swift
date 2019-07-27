//
//  F.DisplayName.swift
//  Stores
//
//  Created by Artem Chabannyi on 4/22/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Validators
import BackendServices

extension F {
    static func displayNameValidation(fullName: String?) -> SignalProducer<Void, StoreError> {
        return SignalProducer<Void, StoreError> { (observer, lifetime) in
            if let fullName = fullName {
                switch isDisplayNameValid(displayName: fullName) {
                case .success:
                    observer.send(value: ())
                    observer.sendCompleted()
                case .failure(let error):
                    switch error {
                    case .minLength(let value):
                        observer.send(error: StoreError.invalidFields(FieldsError(errors: ["displayName": "Display Name should be minimum \(value) characters"])))
                    }
                }
            } else {
                observer.send(value: ())
                observer.sendCompleted()
            } }
    }
}
