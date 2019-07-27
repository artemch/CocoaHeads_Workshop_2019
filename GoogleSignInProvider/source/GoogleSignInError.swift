//
//  GoogleSignInError.swift
//  GoogleSignInProvider
//
//  Created by Artem Chabannyi on 2/13/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public enum GoogleSignInError: Error {
    case failure(reason: String)
}
