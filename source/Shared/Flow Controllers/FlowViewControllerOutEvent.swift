//
//  FlowViewControllerOutEvent.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/18/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//
import Foundation
import ReactiveSwift
import ReactiveSwiftKit

public protocol FlowViewControllerOutEvent {
    associatedtype EventAction
    typealias EventEmitter = ReactiveSwiftKit.EventEmitter<EventAction>
    var event: EventEmitter.EventSignal { get }
}
