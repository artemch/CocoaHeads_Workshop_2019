//
//  KeyboardFocusPreviousNext.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 3/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManager

protocol KeyboardFocusPreviousNext: class {
    
    static func enableToolbarPreviousNext()
    
    func enableToolbarPreviousNext()
}

extension KeyboardFocusPreviousNext where Self: UIView {
    static func enableToolbarPreviousNext() {
        IQKeyboardManager.shared().toolbarPreviousNextAllowedClasses.add(type(of: self))
    }
    
    func enableToolbarPreviousNext() {
        IQKeyboardManager.shared().toolbarPreviousNextAllowedClasses.add(type(of: self))
    }
}
