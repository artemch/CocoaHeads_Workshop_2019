//
//  StoreError.swift
//  Stores
//
//  Created by Artem Chabannyi on 3/13/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import BackendServices

public enum StoreError: Swift.Error {
    case invalidFields(FieldsError)
    case error(reason: String)
}

public extension StoreError {
    var fields: FieldsError? {
        switch self {
        case .invalidFields(let fields):
            return fields
        case .error:
            return nil
        }
    }
}

public extension StoreError {
    var reason: String? {
        switch self {
        case .invalidFields:
            return nil
        case .error(let reason):
            return reason
        }
    }
}
