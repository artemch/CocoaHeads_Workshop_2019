//
//  AutoAuthenticationPresentationModelActionEvent.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import ReactiveSwift
import Result

public enum AutoAuthenticationEventAction: EventActionType {
    case authenticated
    case notAuthenticated
}

public protocol AutoAuthenticationPresentationModelActionEvent {
    typealias EventAction = AutoAuthenticationEventAction
    
    typealias EventSignalType = Signal<EventAction, NoError>
    
    var actionEvent: EventSignalType { get }
}
