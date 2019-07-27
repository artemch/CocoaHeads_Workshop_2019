//
//  SignalProducer+On.swift
//  ReactiveSwiftKit
//
//  Created by Artem Chabannyi on 3/22/19.
//

import Foundation
import ReactiveSwift

public extension SignalProducer {
    func onEvent(_ event: @escaping ((ProducedSignal.Event) -> Void)) -> SignalProducer<Value, Error> {
        return self.on(event: event)
    }
}

public extension SignalProducer {
    func onValue(_ value: @escaping ((Value?) -> Void)) -> SignalProducer<Value, Error> {
        return self.on(event: { (event) in
            switch event {
            case .value(let v):
                value(v)
            default:
                value(nil)
            }
        })
    }
}
