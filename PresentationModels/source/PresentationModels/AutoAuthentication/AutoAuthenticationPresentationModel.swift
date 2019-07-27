//
//  AutoAuthenticationPresentationModel.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/25/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import Services
import ReactiveSwift
import Result

public enum AutoAuthenticationViewData {
    case auth(action: () -> ())
    case checking
    case notAuthorized
    case authorized
    
    public static var initial: AutoAuthenticationViewData {
        return .auth(action: {})
    }
}

public protocol AutoAuthenticationPresentationModel: PresentationModel where ViewData == AutoAuthenticationViewData {
    
}
