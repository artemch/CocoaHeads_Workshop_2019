//
//  SignalProducer+Log.swift
//  Alamofire
//
//  Created by Artem Chabannyi on 2/27/19.
//

import ReactiveSwift

public extension SignalProducer {
    func logDebugEvents(events: Set<LoggingEvent.SignalProducer> = Set(arrayLiteral: .failed)) -> SignalProducer<Value, Error> {
        return self.logEvents(identifier: "Debug", events: events, logger: debugLog)
    }
}

fileprivate func debugLog(identifier: String, event: String, fileName: String, functionName: String, lineNumber: Int) {
    #if DEBUG
        print("\(identifier): \(event)")
        print(fileName)
    #endif
}
