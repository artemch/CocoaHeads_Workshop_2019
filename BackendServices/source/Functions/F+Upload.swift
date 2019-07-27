//
//  F+Upload.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 3/28/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift
import AlamofireReactive

extension F {
    static func upload<Value: Decodable>(sessionManager: SessionManager,
                                         url: URLConvertible,
                                         headers: HTTPHeaders? = nil,
                                         multipartFormData: @escaping (MultipartFormData) -> Void) -> SignalProducer<Value, BackendError>
    {
        return SignalProducer<UploadRequest, BackendError> { (observer, lifetime) in
            sessionManager.upload(multipartFormData: multipartFormData,
                                  usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
                                  to: url,
                                  method: .post,
                                  headers: headers,
                                  queue: nil,
                                  encodingCompletion: { result in
                                    switch result {
                                    case .success(let upload, _, _):
                                        observer.send(value: upload)
                                        observer.sendCompleted()
                                    case .failure(let encodingError):
                                        observer.send(error: BackendError.error(reason: encodingError.localizedDescription))
                                    }
                                    }
            )}.flatMap(.latest) { (upload: UploadRequest) -> SignalProducer<Value, BackendError> in
                return upload.reactive.responseData().flatMap(.latest, F.response).flatMap(.latest, F.decode)
            }
    }
}

extension F {
    static func uplodWithToken<Value: Decodable>(tokenProvider: AccessTokenProvider,
                                                 ssessionManager: SessionManager,
                                                 url: URLConvertible,
                                                 headers: HTTPHeaders? = nil,
                                                 multipartFormData: @escaping (MultipartFormData) -> Void) -> SignalProducer<Value, BackendError>
    {
        return self.retriveToken(tokenProvider: tokenProvider, headers: headers)
            .flatMap(.latest) { headers in
                return self.upload(sessionManager: ssessionManager, url: url, headers: headers, multipartFormData: multipartFormData)
        }
    }
}

extension F {
    static func uplodWithToken(tokenProvider: AccessTokenProvider,
                               ssessionManager: SessionManager,
                               url: URLConvertible,
                               headers: HTTPHeaders? = nil,
                               multipartFormData: @escaping (MultipartFormData) -> Void) -> SignalProducer<Void, BackendError>
    {
        return self.uplodWithToken(tokenProvider: tokenProvider,
                                   ssessionManager: ssessionManager,
                                   url: url,
                                   headers: headers,
                                   multipartFormData: multipartFormData)
            .map { (v: Response.Empty) in () }
    }
}
