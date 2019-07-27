//
//  LogOutBackendServiceImp.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public class LogOutBackendServiceImp: AuthorizedBackendService, LogOutBackendService {
    
    // MARK: - Public methods
    
    public func logOut() -> SignalProducer<Void, BackendError> {
        let url = self.pathBuilder.append(component: "accounts/logout").build()
        return F.postWithToken(tokenProvider: self.tokenProvider,
                               sessionManager: self.sessionManager,
                               url: url)
    }
    
}
