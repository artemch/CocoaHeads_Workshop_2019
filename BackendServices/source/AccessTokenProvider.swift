//
//  AccessTokenProvider.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import Models

public protocol AccessTokenProvider {
    func retriveAccessToken() -> SignalProducer<AccessToken?, NoError>
}
