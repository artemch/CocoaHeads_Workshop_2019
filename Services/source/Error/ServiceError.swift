//
//  ServiceError.swift
//  Services
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import BackendServices
import SharedLocalization

public enum ServiceError: Error {
    case error(reason: String)
    case errorResponse(error: ResponseError)
}

extension ServiceError {
    static var undefined: ServiceError {
        return .error(reason: L10n.Errors.undefined)
    }
}
