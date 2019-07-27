//
//  Profile.swift
//  Models
//
//  Created by Artem Chabannyi on 3/27/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public typealias UserId = ID<Int>

public struct Profile: EntityModel, Equatable {
    public let id: UserId
    public let displayName: String?
    public let avatar: String
    public let email: String
    
    // MARK: - Initializations and Deallocations
    
    public init(id: UserId,
                displayName: String?,
                avatar: String,
                email: String) {
        self.id = id
        self.displayName = displayName
        self.avatar = avatar
        self.email = email
    }
}
