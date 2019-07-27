import Foundation
import ReactiveSwift
import Alamofire
import Models
import SharedLocalization

extension F {
    static func response(responseData: DataResponse<Data>) -> SignalProducer<RawData, BackendError> {
        return SignalProducer { (observer, lifetime) in
            if let response = responseData.response, erorrsStatusCodes.contains(response.statusCode) {
                let statusCode = response.statusCode
                let responseError = decodeResponseError(statusCode: statusCode, data: responseData.data ?? RawData())
                observer.send(error: .errorResponse(error: responseError))
            } else if let error = responseData.error {
                observer.send(error: Transformers.Error.transformInternalResponseError(error))
            } else if let data = responseData.result.value {
                observer.send(value: data)
                observer.sendCompleted()
            } else {
                observer.send(error: .undefined)
            }
        }
    }
}

private let erorrsStatusCodes = (400...599)

extension F {
    static func handleAccessToken(token: AccessToken?) -> SignalProducer<AccessToken, BackendError> {
        
        return token.map { SignalProducer(value: $0) } ??
            {
                return SignalProducer(error: .error(reason: L10n.Errors.accessTokenMissing))
            }()
    }
}
