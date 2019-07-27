//
//  Transformers+NSError.swift
//  Services
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import GoogleSignInProvider

extension Transformers {
    enum Error { }
}

extension Transformers.Error {
    static func transformNSError(error: NSError) -> ServiceError {
        return .error(reason: error.localizedDescription)
    }
}

extension Transformers.Error {
    static func transformGoogleSignInError(error: GoogleSignInError) -> ServiceError {
        switch error {
        case .failure(let reason):
            return .error(reason: reason)
        }
    }
}
