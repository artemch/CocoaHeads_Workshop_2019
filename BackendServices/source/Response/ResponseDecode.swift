//
//  ResponseDecode.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/27/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

@dynamicMemberLookup
public struct FieldsError {
    public let errors: Dictionary<String, String>?
    
    public init(errors: Dictionary<String, String>?) {
        self.errors = errors
    }
    
    public var isEmapty: Bool {
        return self.errors?.isEmpty ?? true
    }
    
    public subscript(dynamicMember member: String) -> String? {
        return self.errors?[member]
    }
    
    public var errorsString: String? {
        return self.errors?.reduce("", { (result, kV) -> String in
            result + " " + kV.value
        })
    }
}

public struct ResponseError: Error {
    
    public enum Code: Equatable {
        case error(code: Int, statusCode: Int)
        case pageNotFound
        case dataNotFound
        case invalidToken
        case accountIsBlocked
        case accountIsDeleted
        case serverInternalError
        case tokenWasntGenerated
        case accessDenied
        case methodNotAllowed
        case unprocessableEntity
    }
    
    public let code: Code
    public let message: String
    public let errors: FieldsError
    
}

extension ResponseError {
    static func error(statusCode: Int, message: String? = nil) -> ResponseError {
        let m =  message ?? (statusCode < 100 ? "Undefined error" : HTTPURLResponse.localizedString(forStatusCode: statusCode))
        return ResponseError(code: .error(code: 0, statusCode: statusCode),
                             message: m,
                             errors: FieldsError(errors: nil))
    }
}

func decodeResponseError(statusCode: Int, data: Data) -> ResponseError {
    let decoder = JSONDecoder()
    do {
        let value = try decoder.decode(ResponseErrorInternal.self, from: data)
        return transform(responseErrorInternal:value, statusCode: statusCode)
    } catch {
        return ResponseError.error(statusCode: statusCode)
    }
}

struct ResponseErrorInternal: Decodable {
    let code: Int
    let message: String
    let errors: Dictionary<String, String>?
}

func transform(responseErrorInternal: ResponseErrorInternal, statusCode: Int) -> ResponseError {
    var code = ResponseError.Code.error(code: responseErrorInternal.code, statusCode: statusCode)
    switch (statusCode, responseErrorInternal.code) {
    case (404, 0):
        code = .pageNotFound
    case (404, 2):
        code = .dataNotFound
    case (401, 0):
        code = .invalidToken
    case (401, 2):
        code = .accountIsBlocked
    case (401, 3):
        code = .accountIsDeleted
    case (500, 0):
        code = .serverInternalError
    case (500, 1):
        code = .tokenWasntGenerated
    case (403, 0):
        code = .accessDenied
    case (405, 0):
        code = .methodNotAllowed
    case (422, 0):
        code = .unprocessableEntity
    default:
        break
    }
    return ResponseError(code: code,
                         message: responseErrorInternal.message,
                         errors: FieldsError(errors: responseErrorInternal.errors))
}
