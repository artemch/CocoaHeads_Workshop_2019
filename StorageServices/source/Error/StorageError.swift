//
//  StorageError.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public enum StorageError: Error {
    case error(reason: String)
}

extension StorageError {
    static var undefined: StorageError {
        return .error(reason: "Undefined error")
    }
}
