//
//  Transformers+StorageError.swift
//  Services
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import StorageServices

extension Transformers {
    enum StorageError {
        
    }
}

extension Transformers.StorageError {
    static func transform(error: StorageError) -> ServiceError {
        switch error {
        case .error(let reason):
            return .error(reason: reason)
        }
    }
}
