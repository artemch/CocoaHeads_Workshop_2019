//
//  LogOutService.swift
//  Services
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

//sourcery: AutoMockable
public protocol LogOutService {
    
    func logOut() -> SignalProducer<(), NoError>
    
}
