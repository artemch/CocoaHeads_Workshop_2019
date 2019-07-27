//
//  KeyboardFocusViewController.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManager

protocol KeyboardFocusViewController: class {
    static func enableKeyboardFocus()
    
    static func disabledKeyboardFocus()
    
    func enableKeyboardFocus()
    
    func disabledKeyboardFocus()
}

extension KeyboardFocusViewController where Self: UIViewController {
    static func enableKeyboardFocus() {
        IQKeyboardManager.shared().enabledDistanceHandlingClasses.add(type(of: self))
    }
    
    static func disabledKeyboardFocus() {
        IQKeyboardManager.shared().disabledDistanceHandlingClasses.add(type(of: self))
    }
}

extension KeyboardFocusViewController where Self: UIViewController {
    func enableKeyboardFocus() {
        IQKeyboardManager.shared().enabledDistanceHandlingClasses.add(type(of: self))
    }
    
    func disabledKeyboardFocus() {
        IQKeyboardManager.shared().disabledDistanceHandlingClasses.add(type(of: self))
    }
}
