//
//  Functions.Request.WithToken.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/22/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire

extension F {
    static func retriveToken(tokenProvider: AccessTokenProvider,
                             headers: HTTPHeaders? = nil) -> SignalProducer<HTTPHeaders, BackendError>
    {
        return tokenProvider.retriveAccessToken()
            .flatMap(.latest)
            { token in token.flatMap { token in SignalProducer(value: token) } ?? SignalProducer(error: .noToken) }
            .map { token in
                let token = token
                var h = headers ?? HTTPHeaders()
                h.updateValue("Bearer \(token)", forKey: "Authorization")
                return h
        }
    }
}

extension F {
    static func requestWithToken<Value: Decodable>(tokenProvider: AccessTokenProvider,
                                          sessionManager: SessionManager,
                                          url: URLConvertible,
                                          method: HTTPMethod,
                                          parameters: Parameters? = nil,
                                          encoding: ParameterEncoding = URLEncoding.default,
                                          headers: HTTPHeaders? = nil,
                                          decoder: @escaping (RawData) -> SignalProducer<Value, BackendError> = F.decode) -> SignalProducer<Value, BackendError>
    {
        return self.retriveToken(tokenProvider: tokenProvider, headers: headers)
            .flatMap(.latest) { self.request(sessionManager: sessionManager,
                                             url: url, method: method,
                                             parameters: parameters,
                                             encoding: encoding,
                                             headers: $0,
                                             decoder: decoder) }
    }
}

extension F {
    static func getWithToken<Value: Decodable>(tokenProvider: AccessTokenProvider,
                                      sessionManager: SessionManager,
                                      url: URLConvertible,
                                      parameters: Parameters? = nil,
                                      encoding: ParameterEncoding = URLEncoding.default,
                                      headers: HTTPHeaders? = nil,
                                      decoder: @escaping (RawData) -> SignalProducer<Value, BackendError> = F.decode) -> SignalProducer<Value, BackendError>
    {
        return self.requestWithToken(tokenProvider: tokenProvider,
                            sessionManager: sessionManager,
                            url: url,
                            method: .get,
                            parameters: parameters,
                            encoding: encoding,
                            headers: headers,
                            decoder: decoder)
    }
}

extension F {
    static func postWithToken<Value: Decodable>(tokenProvider: AccessTokenProvider,
                                      sessionManager: SessionManager,
                                      url: URLConvertible,
                                      parameters: Parameters? = nil,
                                      encoding: ParameterEncoding = URLEncoding.default,
                                      headers: HTTPHeaders? = nil) -> SignalProducer<Value, BackendError>
    {
        return self.requestWithToken(tokenProvider: tokenProvider,
                            sessionManager: sessionManager,
                            url: url,
                            method: .post,
                            parameters: parameters,
                            encoding: encoding,
                            headers: headers)
    }
}

extension F {
    static func putWithToken<Value: Decodable>(tokenProvider: AccessTokenProvider,
                                                sessionManager: SessionManager,
                                                url: URLConvertible,
                                                parameters: Parameters? = nil,
                                                encoding: ParameterEncoding = URLEncoding.default,
                                                headers: HTTPHeaders? = nil) -> SignalProducer<Value, BackendError>
    {
        return self.requestWithToken(tokenProvider: tokenProvider,
                                     sessionManager: sessionManager,
                                     url: url,
                                     method: .put,
                                     parameters: parameters,
                                     encoding: encoding,
                                     headers: headers)
    }
}

extension F {
    static func deleteWithToken<Value: Decodable>(tokenProvider: AccessTokenProvider,
                                               sessionManager: SessionManager,
                                               url: URLConvertible,
                                               parameters: Parameters? = nil,
                                               encoding: ParameterEncoding = URLEncoding.default,
                                               headers: HTTPHeaders? = nil) -> SignalProducer<Value, BackendError>
    {
        return self.requestWithToken(tokenProvider: tokenProvider,
                                     sessionManager: sessionManager,
                                     url: url,
                                     method: .delete,
                                     parameters: parameters,
                                     encoding: encoding,
                                     headers: headers)
    }
}

extension F {
    static func requestWithToken(tokenProvider: AccessTokenProvider,
                                 sessionManager: SessionManager,
                                 url: URLConvertible,
                                 method: HTTPMethod,
                                 parameters: Parameters? = nil,
                                 encoding: ParameterEncoding = URLEncoding.default,
                                 headers: HTTPHeaders? = nil) -> SignalProducer<Void, BackendError>
    {
        return self.requestWithToken(tokenProvider: tokenProvider,
                                     sessionManager: sessionManager,
                                     url: url,
                                     method: method,
                                     parameters: parameters,
                                     encoding: encoding,
                                     headers: headers)
            .map { (v: Response.Empty) in () }
    }
}

extension F {
    static func postWithToken(tokenProvider: AccessTokenProvider,
                              sessionManager: SessionManager,
                              url: URLConvertible,
                              parameters: Parameters? = nil,
                              encoding: ParameterEncoding = URLEncoding.default,
                              headers: HTTPHeaders? = nil) -> SignalProducer<Void, BackendError>
    {
        return self.requestWithToken(tokenProvider: tokenProvider,
                                     sessionManager: sessionManager,
                                     url: url,
                                     method: .post,
                                     parameters: parameters,
                                     encoding: encoding,
                                     headers: headers)
            .map { (v: Response.Empty) in () }
    }
}

extension F {
    static func deleteWithToken(tokenProvider: AccessTokenProvider,
                              sessionManager: SessionManager,
                              url: URLConvertible,
                              parameters: Parameters? = nil,
                              encoding: ParameterEncoding = URLEncoding.default,
                              headers: HTTPHeaders? = nil) -> SignalProducer<Void, BackendError>
    {
        return self.requestWithToken(tokenProvider: tokenProvider,
                                     sessionManager: sessionManager,
                                     url: url,
                                     method: .delete,
                                     parameters: parameters,
                                     encoding: encoding,
                                     headers: headers)
            .map { (v: Response.Empty) in () }
    }
}

extension F {
    static func putWithToken(tokenProvider: AccessTokenProvider,
                                sessionManager: SessionManager,
                                url: URLConvertible,
                                parameters: Parameters? = nil,
                                encoding: ParameterEncoding = URLEncoding.default,
                                headers: HTTPHeaders? = nil) -> SignalProducer<Void, BackendError>
    {
        return self.requestWithToken(tokenProvider: tokenProvider,
                                     sessionManager: sessionManager,
                                     url: url,
                                     method: .put,
                                     parameters: parameters,
                                     encoding: encoding,
                                     headers: headers)
            .map { (v: Response.Empty) in () }
    }
}
