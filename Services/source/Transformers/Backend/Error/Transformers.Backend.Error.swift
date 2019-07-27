//
//  Transformers+BackendError.swift
//  Services
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import BackendServices
import SharedLocalization

extension Transformers {
    enum BackendError { }
}

extension Transformers.BackendError {
    static func transform(error: BackendError) -> ServiceError {
        switch error {
        case .error(let reason):
            return .error(reason: reason)
        case .failedDecoding(let description):
            return .error(reason: description)
        case .noToken:
            return .error(reason: L10n.Errors.noToken)
        case .errorResponse(let error):
            return .errorResponse(error: error)
        }
    }
}
