//
//  LoginCredential.swift
//  Models
//
//  Created by Artem Chabannyi on 2/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public enum LoginCredential {
    case email(String, password: String)
    case google
}
