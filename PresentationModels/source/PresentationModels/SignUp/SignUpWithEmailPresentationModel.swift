//
//  SignUpWithEmailPresentationModel.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/25/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Services
import Models
import Validators

public struct SignUpWithEmailViewData {
    public let email: String
    public let password: String
    public let isAgree: Bool
    public let emailError: String?
    public let passwordError: String?
    public let isAgreeError: String?
    public let isShowPassword: Bool
    public let isLoading: Bool
    public let fullName: String?
    public let fullNameError: String?
    public let alertError: AlertError?
    public let onSignUp: (() -> ())?
    public let onUpdatePassword: ((String) -> ())?
    public let onUpdateLogin: ((String) -> ())?
    public let onAgree: (() -> ())?
    public let back: (() -> ())?
    public let onHaveAccount: (() -> ())?
    public let onTermsAndConditions: (() -> ())?
    public let onShowPassword: (() -> ())?
    public let onUpdateFullName: ((String?) -> ())?
    
    static var initial: SignUpWithEmailViewData {
        return SignUpWithEmailViewData(email: "",
                                       password: "",
                                       isAgree: false,
                                       emailError: nil,
                                       passwordError: nil,
                                       isAgreeError: nil,
                                       isShowPassword: false,
                                       isLoading: false,
                                       fullName: nil,
                                       fullNameError: nil,
                                       alertError: nil,
                                       onSignUp: nil,
                                       onUpdatePassword: nil,
                                       onUpdateLogin: nil,
                                       onAgree: nil,
                                       back: nil,
                                       onHaveAccount: nil,
                                       onTermsAndConditions: nil,
                                       onShowPassword: nil,
                                       onUpdateFullName: nil)
    }
}

public protocol SignUpWithEmailPresentationModel: PresentationModel where ViewData == SignUpWithEmailViewData {
    
}


