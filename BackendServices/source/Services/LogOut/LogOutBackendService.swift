//
//  LogOutBackendService.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

//sourcery: AutoMockable
public protocol LogOutBackendService {
    
    func logOut() -> SignalProducer<Void, BackendError>
    
}
