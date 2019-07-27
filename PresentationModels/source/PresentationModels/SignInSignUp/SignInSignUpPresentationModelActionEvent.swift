//
//  SignInSignUpPresentationModelActionEvent.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import ReactiveSwift
import Result

public enum SignInSignUpEventAction: EventActionType {
    case logIn
    case signUp
    case signInGoogle
}

public protocol SignInSignUpPresentationModelActionEvent {
    typealias EventAction = SignInSignUpEventAction
    
    typealias EventSignalType = Signal<EventAction, NoError>
    
    var actionEvent: EventSignalType { get }
}


