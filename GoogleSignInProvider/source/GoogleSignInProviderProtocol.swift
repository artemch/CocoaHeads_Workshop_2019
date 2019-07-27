//
//  GoogleSignInProviderProtocol.swift
//  GoogleSignInProvider
//
//  Created by Artem Chabannyi on 5/30/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import ReactiveSwift
import Result

//sourcery: AutoMockable
public protocol GoogleSignInProviderProtocol: class {
  
    var signInEvent: Signal<GoogleSignInResult, NoError> { get }
    
    func signIn() -> SignalProducer<GoogleSignInResult, NoError>
    
    func signOut() -> SignalProducer<Void, NoError>
    
    func provider(open url: URL,
                  options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
}
