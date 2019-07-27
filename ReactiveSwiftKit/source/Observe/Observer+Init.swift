//
//  Observer+Init.swift
//  ReactiveSwiftKit
//
//  Created by Artem Chabannyi on 2/8/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public extension Signal.Observer {
    convenience init(value: @escaping (Value) -> Void) {
        self.init { (event: Signal<Value, Error>.Event) in
            switch event {
            case .value(let v):
                value(v)
            default: break
            }
        }
    }
}
