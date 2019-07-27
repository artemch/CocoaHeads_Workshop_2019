//
//  SecurityStorage.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models

//sourcery: AutoMockable
public protocol SecurityStorage {
    
    func saveAuthUserToken(token: AccessToken)
    
    func retriveAuthUserToken() -> AccessToken?
    
    func removeUserAuthToken()
}
