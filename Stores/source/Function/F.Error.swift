//
//  F.Error.swift
//  Stores
//
//  Created by Artem Chabannyi on 3/13/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Services
import Validators
import BackendServices
import SharedLocalization

extension F {
    enum Error {}
}

extension F.Error {
    static func transform(error: ServiceError) -> StoreError {
        switch error {
        case .error(let reason):
            return .error(reason: reason)
        case .errorResponse(let error):
            return .invalidFields(error.errors)
        }
    }
}

extension F.Error {
    static func transform(error: BackendError) -> StoreError {
        switch error {
        case .error(let reason):
            return .error(reason: reason)
        case .errorResponse(let error):
            return error.errors.isEmapty ? .error(reason: error.message) : .invalidFields(error.errors)
        case .failedDecoding(let description):
            return .error(reason: description)
        case .noToken:
            return .error(reason: L10n.Errors.noToken)
        }
    }
}

extension F.Error {
    static func transform(error: LoginValidationError) -> StoreError {
        return .invalidFields(F.Error.transform(error: error))
    }
}

extension F.Error {
    static func transform(error: SignUpValidationError) -> StoreError {
        return .invalidFields(F.Error.transform(error: error))
    }
}

extension F.Error {
    static func transform(error: Validators.EmailError) -> StoreError {
        switch error {
        case .email:
            return .invalidFields(FieldsError(errors: ["email": L10n.Errors.invalidEmail]))
        }
    }
}

extension F.Error {
    static func transform(error: Validators.ChangePasswordError) -> StoreError {
        switch error {
        case .invalidNewPassword:
            return .invalidFields(FieldsError(errors: ["password": L10n.Errors.invalidPassword]))
        case .invalidOldPassword:
            return .invalidFields((FieldsError(errors: ["oldPassword": L10n.Errors.invalidPassword])))
        case .invalidPasswords:
            return .invalidFields(FieldsError(errors: ["password": L10n.Errors.invalidPassword, "oldPassword": L10n.Errors.invalidPassword]))
        case .passwordsShouldNotMatch:
            return .invalidFields(FieldsError(errors: ["password": L10n.Errors.passwordsMustNotMatch]))
        }
    }
}

extension F.Error {
    static func transform(error: LoginValidationError) -> FieldsError {
        switch error {
        case .email:
            return FieldsError(errors: ["email": L10n.Errors.invalidEmail])
        case .password:
            return FieldsError(errors: ["password": L10n.Errors.invalidPassword])
        case .emailAndPassword:
            return FieldsError(errors: ["email": L10n.Errors.invalidEmail,
                                        "password": L10n.Errors.invalidPassword])
        }
    }
}

extension F.Error {
    static func transform(error: SignUpValidationError) -> FieldsError {
        switch error {
        case .email:
            return FieldsError(errors: ["email": L10n.Errors.invalidEmail])
        case .password:
            return FieldsError(errors: ["password": L10n.Errors.invalidPassword])
        case .emailAndPassword:
            return FieldsError(errors: ["email": L10n.Errors.invalidEmail,
                                        "password": L10n.Errors.invalidPassword])
        }
    }
}
