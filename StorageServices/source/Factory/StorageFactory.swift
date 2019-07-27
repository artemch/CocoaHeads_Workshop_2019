//
//  StorageFactory.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models

public protocol StorageFactory {
    
    func securityStorage() -> SecurityStorage
    
    func logOutStorage() -> LogOutStorage
    
    func accountStorage() -> AccountStorage
}
