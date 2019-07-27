//
//  Signal+ObserveOnMain.swift
//  ReactiveSwiftKit
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import ReactiveSwift

public extension Signal {
    /// Always targets the main thread’s GCD queue.
    /// Unlike UIScheduler, this scheduler supports scheduling for a future date, and will always schedule asynchronously (even if already running on the main thread).
    func observeOnMain() -> Signal<Value, Error> {
        return self.observe(on: QueueScheduler.main)
    }
}
