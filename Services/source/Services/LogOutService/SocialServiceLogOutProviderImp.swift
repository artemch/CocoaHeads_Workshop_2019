//
//  SocialServiceLogOutProviderImp.swift
//  Services
//
//  Created by Artem Chabannyi on 3/22/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public class SocialServiceLogOutProviderImp: SocialServiceLogOutProvider {
    
    let logOutClosure: () -> SignalProducer<Void, NoError>
    
    // MARK: - Initializations and Deallocations
    
    public init(logOutClosure: @escaping () -> SignalProducer<Void, NoError>) {
        self.logOutClosure = logOutClosure
    }
    
    // MARK: - Public methods
    
    public func logOut() -> SignalProducer<Void, NoError> {
        return self.logOutClosure()
    }
}
