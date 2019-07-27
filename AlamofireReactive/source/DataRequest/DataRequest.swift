//
//  DataRequest.swift
//  AlamofireReactive
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift
import Result

public extension IDPReactive where Base: DataRequest {
    func responseData(
        queue: DispatchQueue? = nil)
        -> SignalProducer<DataResponse<Data>, NoError>
    {
        return SignalProducer { (observer, lifetime) in
            self.base.responseData(queue: queue, completionHandler: { (dataResponse) in
                observer.send(value: dataResponse)
                observer.sendCompleted()
            })
        }
    }
}

public extension IDPReactive where Base: DataRequest {
    func responseJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments)
        -> SignalProducer<DataResponse<Any>, NoError>
    {
        return SignalProducer { (observer, lifetime) in
            self.base.responseJSON(queue: queue,
                                   options: options,
                                   completionHandler: { dataResponse in
                                    observer.send(value: dataResponse)
                                    observer.sendCompleted()
            })
        }
    }
}
