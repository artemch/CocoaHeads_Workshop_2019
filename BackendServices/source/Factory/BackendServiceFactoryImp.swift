//
//  BackendServiceFactoryImp.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/10/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Alamofire

public class BackendServiceFactoryImp: BackendServiceFactory {
    
    private let sessionManager: SessionManager
    
    private let accessTokenProvider: AccessTokenProvider
    
    private let pathBuilder: URLPathBuilder
    
    // MARK: - Initializations and Deallocations
    
    public init(host: String, accessTokenProvider: AccessTokenProvider) {
        self.accessTokenProvider = accessTokenProvider
        self.sessionManager = BackendServiceFactoryImp.F.sessionManager()
        self.pathBuilder = URLPathBuilder(host: host, version: "v1", components: [])
    }
    
    // MARK: - Public methods
    
    public func autoAuthentication() -> AutoAuthenticationBackendService {
        return AutoAuthenticationBackendServiceImp(sessionManager: self.sessionManager,
                                                   pathBuilder: self.pathBuilder,
                                                   accessTokenProvider: self.accessTokenProvider)
    }
    
    public func login() -> LoginBackendService {
        let email = LoginWithEmailBackendServiceImp(sessionManager: self.sessionManager,
                                                    pathBuilder: self.pathBuilder)
        let google = LoginWithGoogleBackendServiceImp(sessionManager: self.sessionManager,
                                                      pathBuilder: self.pathBuilder)
        return LoginBackendServiceImp(email: email,
                                      google: google)
    }
    
    public func logOut() -> LogOutBackendService {
        return LogOutBackendServiceImp(sessionManager: self.sessionManager,
                                       pathBuilder: self.pathBuilder,
                                       tokenProvider: self.accessTokenProvider)
    }
    
    public func signUp() -> SignUpBackendService {
        return SignUpBackendServiceImp(sessionManager: self.sessionManager,
                                       pathBuilder: self.pathBuilder)
    }
    
    public func resetPassword() -> ResetPasswordBackendService {
        return ResetPasswordBackendServiceImp(sessionManager: self.sessionManager,
                                              pathBuilder: self.pathBuilder)
    }
}

fileprivate extension BackendServiceFactoryImp {
    enum F { }
}

fileprivate extension BackendServiceFactoryImp.F {
    static func sessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        let languageCode = Locale.current.languageCode ?? "en"
        let headers: [AnyHashable : Any] = ["Content-Type": "application/json",
                                            "Accept": "application/json",
                                            "Accept-Language": languageCode]
        
        let httpAdditionalHeaders = configuration.httpAdditionalHeaders.map {
            var httpAdditionalHeaders = $0
            headers.forEach({ (arg) in
                let (key, value) = arg
                httpAdditionalHeaders.updateValue(value, forKey: key)
            })
            return httpAdditionalHeaders
        } ?? headers
        configuration.httpAdditionalHeaders = httpAdditionalHeaders
        configuration.timeoutIntervalForRequest = 30
        
        let sessionManager = SessionManager(configuration: configuration)
        
        return sessionManager
    }
}
