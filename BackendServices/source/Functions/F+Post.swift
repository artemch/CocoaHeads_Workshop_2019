//
//  F+Post.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 3/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire

extension F {
    static func post<Value: Decodable>(sessionManager: SessionManager,
                                       url: URLConvertible,
                                       parameters: Parameters? = nil,
                                       encoding: ParameterEncoding = URLEncoding.default,
                                       headers: HTTPHeaders? = nil) -> SignalProducer<Value, BackendError>
    {
        return F.request(sessionManager: sessionManager,
                         url: url,
                         method: .post,
                         parameters: parameters,
                         encoding: encoding,
                         headers: headers)
    }
}

extension F {
    static func post(sessionManager: SessionManager,
                     url: URLConvertible,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: HTTPHeaders? = nil) -> SignalProducer<Void, BackendError>
    {
        return F.post(sessionManager: sessionManager,
                      url: url,
                      parameters: parameters,
                      encoding: encoding,
                      headers: headers)
            .map { (v: Response.Empty) in () }
    }
}
