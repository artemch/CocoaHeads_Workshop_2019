//
//  TermsAndConditionsPresentationModelEventAction.swift
//  PresentationModels
//
//  Created by Artem Chabannyi on 3/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public extension TermsAndConditionsPresentationModel {
    enum EventAction: EventActionType {
        case back
        case agree
    }
}

public protocol TermsAndConditionsPresentationModelActionEvent {
    typealias EventAction = TermsAndConditionsPresentationModel.EventAction
    
    typealias EventSignalType = Signal<EventAction, NoError>
    
    var actionEvent: EventSignalType { get }
}
