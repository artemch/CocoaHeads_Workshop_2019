//
//  AlertError.swift
//  PresentationModels
//
//  Created by Artem Chabannyi on 4/5/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public struct AlertErrorAction {
    public let title: String?
    public let style: UIAlertAction.Style
    public let action: () -> ()
}

public struct AlertError: Equatable {
    public let title: String?
    public let message: String?
    public let actions: [AlertErrorAction]
    
    public static func == (lhs: AlertError, rhs: AlertError) -> Bool {
        return lhs.title == rhs.title &&
            lhs.message == rhs.message
    }
}
