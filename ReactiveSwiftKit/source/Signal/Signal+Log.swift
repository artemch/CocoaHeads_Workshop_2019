//
//  Signal+Log.swift
//  Alamofire
//
//  Created by Artem Chabannyi on 2/27/19.
//

import ReactiveSwift

public extension Signal {
    func logDebugEvents(events: Set<LoggingEvent.Signal> = Set(arrayLiteral: .failed)) -> Signal<Value, Error> {
        return self.logEvents(identifier: "Debug", events: events, logger: debugLog)
    }
}

fileprivate func debugLog(identifier: String, event: String, fileName: String, functionName: String, lineNumber: Int) {
    #if DEBUG
    print("\(identifier): \(event)")
    print(fileName)
    #endif
}
