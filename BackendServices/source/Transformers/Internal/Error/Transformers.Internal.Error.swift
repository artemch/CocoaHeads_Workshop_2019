//
//  Transformers+Error.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Alamofire
import SharedLocalization

extension Transformers {
    enum Error { }
}

extension Transformers.Error {
    static func transformInternalResponseError(_ error: Error) -> BackendError {
        if let error = error as? AFError {
            switch error {
            case .invalidURL,
                 .multipartEncodingFailed,
                 .parameterEncodingFailed:
                return .error(reason: L10n.Errors.inputFailed)
            case .responseSerializationFailed,
                 .responseValidationFailed:
                return .error(reason: L10n.Errors.responseFailed)
            }
        } else if let error = error as NSError? {
            return .error(reason: error.localizedDescription)
        } else {
            return .error(reason: L10n.Errors.undefined)
        }
    }
}
