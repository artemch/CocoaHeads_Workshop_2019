//
//  ResetPasswordPresentationModelActionEvent.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/28/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//
import Foundation
import Models
import ReactiveSwift
import Result

public enum ResetPasswordEventAction: EventActionType {
    case back
    case signIn
}

public protocol ResetPasswordPresentationModelActionEvent {
    typealias EventAction = ResetPasswordEventAction
    
    typealias EventSignalType = Signal<EventAction, NoError>
    
    var actionEvent: EventSignalType { get }
}
