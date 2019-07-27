//
//  SignUpWithEmailPresentationModelActionEvent.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import ReactiveSwift
import Result

public enum EventActionSignUpWithEmail: EventActionType {
    case back
    case signedUp
    case haveAccount
    case termsAndConditions
}

public protocol SignUpWithEmailPresentationModelActionEvent {
    typealias EventAction = EventActionSignUpWithEmail
    
    typealias EventSignalType = Signal<EventAction, NoError>
    
    var actionEvent: EventSignalType { get }
}
