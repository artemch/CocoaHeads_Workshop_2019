//
//  Transformers.Error.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 3/5/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

extension Transformers {
    enum Error {}
}

extension Transformers.Error {
    static func transform(error: StorageCodableError) -> StorageError {
        switch error {
        case .missedValue(let value):
            return .error(reason: value)
        }
    }
}
