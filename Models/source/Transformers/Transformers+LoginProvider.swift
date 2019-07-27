//
//  Transformers+LoginProvider.swift
//  Models
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public extension Transformers {
    enum LoginProvider {}
}

public extension Transformers.LoginProvider {
    /**
     If can not transform string provider to LoginProvider type return email provider
    **/
    static func transform(provider: String) -> LoginProvider {
        let lProvider = LoginProvider(rawValue: provider)
        return lProvider ?? .email
    }
}
