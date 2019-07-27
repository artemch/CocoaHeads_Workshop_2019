//
//  EventEmitter.swift
//  Alamofire
//
//  Created by Artem Chabannyi on 2/16/19.
//

import Foundation
import ReactiveSwift
import Result

public class EventEmitter<Value> {
    
    public typealias EventSignal = Signal<Value, NoError>
    
    let (signal, observer) = EventSignal.pipe()
    
    public var event: EventSignal {
        return self.signal
    }
    
    //MARK: - Init
    
    deinit {
        self.observer.sendCompleted()
    }
    
    public init() {
        
    }
    
    //MARK: - Public methods
    
    public func send(value: Value) {
        self.observer.send(value: value)
    }
}
