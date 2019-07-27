//
//  GoogleUISignInProvider.swift
//  GoogleSignInProvider
//
//  Created by Artem Chabannyi on 2/13/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import GoogleSignIn
import Result

public class GoogleUISignInProvider: NSObject, GIDSignInUIDelegate {
    
    public var signInWillDispatch: ((Result<Void, GoogleSignInError>) -> ())?
    
    public var signPresentViewController: ((UIViewController) -> ())?
    
    public var signDismissViewController: ((UIViewController) -> ())?
    
    public override init() {
        super.init()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    // MARK: - GIDSignInUIDelegate
    
    public func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        var result: Result<Void, GoogleSignInError>
        if let error = error as NSError? {
            let gError: GoogleSignInError = .failure(reason: error.localizedDescription)
            result = .failure(gError)
        } else {
            result = .success(())
        }
        self.signInWillDispatch?(result)
    }
    
    public func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.signPresentViewController?(viewController)
    }
    
    public func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.signDismissViewController?(viewController)
    }
    
}
