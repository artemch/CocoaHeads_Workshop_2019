import Foundation
import ReactiveSwift
import Alamofire
import AlamofireReactive

class LoginWithEmailBackendServiceImp: BaseBackendService, LoginWithEmailBackendService {
    
    // MARK: - Public methods
    
    func post(credential: Request.LoginWithEmail) -> SignalProducer<Response.Login, BackendError> {
        return F.jsonMock(fileName: "login")
    }
    
}

fileprivate extension LoginWithEmailBackendServiceImp {
    enum ParametersKeys: String {
        case email
        case password
    }
    
    func parameters(credential: Request.LoginWithEmail) -> [String: Any] {
        return [ParametersKeys.email.rawValue: credential.email,
                ParametersKeys.password.rawValue: credential.password]
    }
}


