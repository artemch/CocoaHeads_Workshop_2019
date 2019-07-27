//
//  F+ModulBundle.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 7/21/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

extension F {
    static func moduleBundle() -> Bundle {
        return Bundle(for: BackendServiceFactoryImp.self)
    }
}

