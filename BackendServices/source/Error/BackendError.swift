//
//  BackendError.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import SharedLocalization

public enum BackendError: Error {
    case error(reason: String)
    case failedDecoding(description: String)
    case noToken
    case errorResponse(error: ResponseError)
}

extension BackendError {
    static var undefined: BackendError {
        return .error(reason: L10n.Errors.undefined)
    }
}
