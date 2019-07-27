//
//  SignInSignUpPresentationModel.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/25/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Models
import Services

public struct SignInSignUpViewData {
    public let isLoading: Bool
    public let onSignIn: (() -> ())?
    public let onSignUp: (() -> ())?
    
    public static var initial: SignInSignUpViewData {
        return SignInSignUpViewData(isLoading: false,
                                    onSignIn: nil,
                                    onSignUp: nil)
    }
}

public protocol SignInSignUpPresentationModel: PresentationModel where ViewData == SignInSignUpViewData {
    
}
