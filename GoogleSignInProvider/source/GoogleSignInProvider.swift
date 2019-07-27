//
//  GoogleSignInProvider.swift
//  GoogleSignInProvider
//
//  Created by Artem Chabannyi on 2/13/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import GoogleSignIn
import ReactiveSwift
import Result

public class GoogleSignInProvider: NSObject, GoogleSignInProviderProtocol, GIDSignInDelegate {
    
    public typealias SignalType = Signal<GoogleSignInResult, NoError>
    
    public var signInEvent: SignalType {
        return self.eventEmitter.output
    }
    
    // MARK: - Private properties
    
    private let clientID: String
    
    private let gidSignIn: GIDSignIn
    
    private let eventEmitter = SignalType.pipe()
    
    // MARK: - Initializations and Deallocations
    
    deinit {
        self.eventEmitter.input.sendCompleted()
    }
    
    public init(clientID: String) {
        self.clientID = clientID
        self.gidSignIn = GIDSignIn.sharedInstance()
        super.init()
        self.gidSignIn.clientID = clientID
        self.gidSignIn.delegate = self

    }
    
    // MARK: - Public methods
    
    public func signIn() -> SignalProducer<GoogleSignInResult, NoError> {
        let signInEventProducer = self.signInEvent.producer
        let gidSignIn = self.gidSignIn
        return SignalProducer<Void, NoError> { (observer, lifetime) in
            gidSignIn.signIn()
            observer.send(value: ())
            observer.sendCompleted()
        }.flatMap(FlattenStrategy.latest) {_ in signInEventProducer }
    }
    
    public func signOut() -> SignalProducer<Void, NoError> {
        return SignalProducer { () -> Void in
            self.gidSignIn.signOut()
        }
    }
    
    public func provider(open url: URL,
                  options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
    {
        return self.gidSignIn.handle(url as URL?,
                                     sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                     annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
    
    // MARK: - GIDSignInDelegate
    
    public func sign(_ signIn: GIDSignIn!,
                     didSignInFor user: GIDGoogleUser!,
                     withError error: Error!)
    {
        if let error = error as NSError? {
            let gError: GoogleSignInError = .failure(reason: error.localizedDescription)
            self.eventEmitter.input.send(value: .failure(gError))
        } else {
            let gUser = GoogleSignInUser(userId: user.userID,
                                         idToken: user.authentication.idToken,
                                         name: user.profile.name,
                                         email: user.profile.email)
            self.eventEmitter.input.send(value: .success(gUser))
        }
    }
    
    public func sign(_ signIn: GIDSignIn!,
                     didDisconnectWith user: GIDGoogleUser!,
                     withError error: Error!)
    {
        
    }
}
