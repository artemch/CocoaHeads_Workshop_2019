//
//  SocialServiceLogOutProvider.swift
//  Services
//
//  Created by Artem Chabannyi on 3/22/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

//sourcery: AutoMockable
public protocol SocialServiceLogOutProvider {
    func logOut() -> SignalProducer<Void, NoError>
}
