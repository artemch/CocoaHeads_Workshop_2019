//
//  Functions+GET.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire

extension F {
    static func request<Value: Decodable>(sessionManager: SessionManager,
                                          url: URLConvertible,
                                          method: HTTPMethod,
                                          parameters: Parameters? = nil,
                                          encoding: ParameterEncoding = URLEncoding.default,
                                          headers: HTTPHeaders? = nil,
                                          decoder: @escaping (RawData) -> SignalProducer<Value, BackendError> = F.decode) -> SignalProducer<Value, BackendError>
    {
        return self.requestRawData(sessionManager: sessionManager,
                                   url: url,
                                   method: method,
                                   parameters: parameters,
                                   encoding: encoding,
                                   headers: headers)
            .flatMap(.latest, decoder)
    }
}

extension F {
    static func requestRawData(sessionManager: SessionManager,
                                          url: URLConvertible,
                                          method: HTTPMethod,
                                          parameters: Parameters? = nil,
                                          encoding: ParameterEncoding = URLEncoding.default,
                                          headers: HTTPHeaders? = nil) -> SignalProducer<RawData, BackendError>
    {
        return sessionManager.request(url,
                                      method: method,
                                      parameters: parameters,
                                      encoding: encoding,
                                      headers: headers)
            .reactive.responseData()
            .flatMap(.latest, F.response)
    }
}

extension F {
    static func request(sessionManager: SessionManager,
                        url: URLConvertible,
                        method: HTTPMethod,
                        parameters: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: HTTPHeaders? = nil) -> SignalProducer<Void, BackendError>
    {
        return self.request(sessionManager: sessionManager,
                            url: url,
                            method: method,
                            parameters: parameters,
                            encoding: encoding,
                            headers: headers)
            .map { (v: Response.Empty) in () }
    }
}
