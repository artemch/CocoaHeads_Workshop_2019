//
//  AppServiceLocator.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/19/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Services
import GoogleSignInProvider

public protocol AppServiceLocator {
    
    var googleSignInProvider: GoogleSignInProvider { get }
    
    var securityService: SecurityService { get }
    
}
