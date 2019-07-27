//
//  KeyboardToolbarAppearance.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 3/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManager

protocol KeyboardToolbarAppearance: class {
    static func enabledKeyboardToolbar()
    
    static func disabledKeyboardToolbar()
    
    func enabledKeyboardToolbar()
    
    func disabledKeyboardToolbar()
}

extension KeyboardToolbarAppearance where Self: UIViewController {
    static func enabledKeyboardToolbar() {
        IQKeyboardManager.shared().enabledToolbarClasses.add(type(of: self))
    }
    
    static func disabledKeyboardToolbar() {
        IQKeyboardManager.shared().disabledToolbarClasses.add(type(of: self))
    }
}

extension KeyboardToolbarAppearance where Self: UIViewController {
    func enabledKeyboardToolbar() {
        IQKeyboardManager.shared().enabledToolbarClasses.add(type(of: self))
    }
    
    func disabledKeyboardToolbar() {
        IQKeyboardManager.shared().disabledToolbarClasses.add(type(of: self))
    }
}
