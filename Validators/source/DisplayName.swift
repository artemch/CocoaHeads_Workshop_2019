//
//  FullName.swift
//  Validators
//
//  Created by Artem Chabannyi on 3/29/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Result

public enum DisplayNameError: Error {
    case minLength(Int)
}

public func isDisplayNameValid(displayName: String) -> Result<Void, DisplayNameError> {
    return displayName.count >= Constants.minDisplayNameLength ? .success(()) :
        .failure(.minLength(Constants.minDisplayNameLength))
}
