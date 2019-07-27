//
//  KeyboardFocusView.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

import IQKeyboardManager

protocol KeyboardFocusView: class {
    static func enableKeyboardFocus(type: UIViewController.Type)
    
    static func disabledKeyboardFocus(type: UIViewController.Type)
}

extension KeyboardFocusView {
    static func enableKeyboardFocus(type: UIViewController.Type) {
        IQKeyboardManager.shared().enabledDistanceHandlingClasses.add(type)
    }
    
    static func disabledKeyboardFocus(type: UIViewController.Type) {
        IQKeyboardManager.shared().disabledDistanceHandlingClasses.add(type)
    }
}
