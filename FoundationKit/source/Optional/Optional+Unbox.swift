//
//  Optional+Unbox.swift
//  FoundationKit
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public extension Optional {
    func `do`(execute: (Wrapped) -> Void) {
        self.map(execute)
    }
}
