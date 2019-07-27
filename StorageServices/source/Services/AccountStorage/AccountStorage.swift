//
//  AccountStorage.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import Models

//sourcery: AutoMockable
public protocol AccountStorage {
    
    typealias ID = UserId
    
    typealias Value = AuthUser
    
    typealias Profile = Models.Profile
    
    func retrieveAuthUser(id: UserId) -> SignalProducer<AuthUser?, StorageError>
    
    func writeAuthUser(model: AuthUser) -> SignalProducer<AuthUser, StorageError>
    
    func deleteAccount(id: UserId) -> SignalProducer<Void, StorageError>
    
    func retrieveProfile(id: UserId) -> SignalProducer<Profile?, StorageError>
    
    func writeProfile(model: Profile) -> SignalProducer<Profile, StorageError>
}
