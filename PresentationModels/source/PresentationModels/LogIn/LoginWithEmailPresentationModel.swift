//
//  LoginWithEmailPresentationModel.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/24/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public struct LoginWithEmailViewData {
    public let login: String
    public let password: String
    public let emailError: String?
    public let passwordError: String?
    public let isShowPassword: Bool
    public let isLoading: Bool
    public let alertError: AlertError?
    public let onLogin: (() -> ())?
    public let onUpdatePassword: ((String) -> ())?
    public let onUpdateLogin: ((String) -> ())?
    public let back: (() -> ())?
    public let resetPassword: (() -> ())?
    public let doNotHaveAccount: (() -> ())?
    public let onShowPassword: (() -> ())?
    
    static var initial: LoginWithEmailViewData {
        return LoginWithEmailViewData(login: "",
                                      password: "",
                                      emailError: nil,
                                      passwordError: nil,
                                      isShowPassword: false,
                                      isLoading: false,
                                      alertError: nil,
                                      onLogin: nil,
                                      onUpdatePassword: nil,
                                      onUpdateLogin: nil,
                                      back: nil,
                                      resetPassword: nil,
                                      doNotHaveAccount: nil,
                                      onShowPassword: nil)
    }
}

public protocol LoginWithEmailPresentationModel: PresentationModel where ViewData == LoginWithEmailViewData {
    
}
