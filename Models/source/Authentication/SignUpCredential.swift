//
//  SignUpCredential.swift
//  Models
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public enum SignUpCredential {
    case email(String, password: String, displayName: String?)
}
