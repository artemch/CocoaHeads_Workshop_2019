//
//  SecurityStorageImp.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import Valet

public class SecurityStorageImp: SecurityStorage {
    
    private let tokenKey = "key"
    
    private let valet: Valet
    
    // MARK: - Initializations and Deallocations
    
    init(valet: Valet) {
        self.valet = valet 
    }
    
    // MARK: - Public methods
    
    public func saveAuthUserToken(token: AccessToken) {
        self.valet.set(string: token, forKey: self.tokenKey)
    }
    
    public func retriveAuthUserToken() -> AccessToken? {
        return self.valet.string(forKey: self.tokenKey)
    }
    
    public func removeUserAuthToken() {
        self.valet.removeObject(forKey: self.tokenKey)
    }
}
