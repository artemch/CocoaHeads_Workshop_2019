//
//  F+Decode.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 3/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire
import Models
import SharedLocalization

typealias RawData = Data

extension F {
    static func jsonDecoder(config: ((JSONDecoder) -> ())? = nil) -> JSONDecoder {
        let decoder = JSONDecoder()
        config?(decoder)
        return decoder
    }
}

extension F {
    static func decode<Value: Decodable>(jsonData: RawData) -> SignalProducer<Value, BackendError> {
        return F.decode(decoder: jsonDecoder())(jsonData)
    }
}

extension F {
    static func decode<Value: Decodable>(decoder: JSONDecoder) -> (RawData) -> SignalProducer<Value, BackendError> {
        return { (jsonData: RawData) in
            return SignalProducer<Value, BackendError> { (observer, lifetime) in
                if Value.self is Response.Empty.Type {
                    observer.send(value: Response.Empty() as! Value)
                    observer.sendCompleted()
                } else {
                    do {
                        let value = try decoder.decode(Value.self, from: jsonData)
                        observer.send(value: value)
                        observer.sendCompleted()
                    } catch {
                        observer.send(error: .failedDecoding(description: error.localizedDescription))
                    }
                }
            }
        }
    }
}
