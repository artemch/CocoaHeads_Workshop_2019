import Foundation
import Models

public enum AuthenticationStoreDomain {
    
    //sourcery: AutoLenses
    public struct Model {
        public let email: String
        public let password: String
        public let isAgree: Bool
        public let displayName: String?
        public let authResult: AuthResult?
        public let resetPassword: ResetPassword
    }
    
    //sourcery: AutoLenses
    public struct ResetPassword {
        public let isLinkSent: Bool
        public let loading: LoadingState<ResetPasswordError>
        
        public static var `default`: AuthenticationStoreDomain.ResetPassword {
            return ResetPassword(isLinkSent: false, loading: .default)
        }
    }
    
    public enum ResetPasswordError: Error {
        case email(String)
        case error(reason: String)
    }
}

public extension LoadingState where Error == AuthenticationStoreDomain.ResetPasswordError {
    var errorReason: String? {
        switch self {
        case .error(let error):
            switch error {
            case .email(let reason):
                return reason
            case .error(let reason):
                return reason
            }
        case .loading, .none:
            return nil
        }
    }
}

public extension AuthenticationStoreDomain.Model {
    static var `default`: AuthenticationStoreDomain.Model {
        return AuthenticationStoreDomain.Model(email: "",
                                               password: "",
                                               isAgree: false,
                                               displayName: nil,
                                               authResult: nil,
                                               resetPassword: .default)
    }
}
