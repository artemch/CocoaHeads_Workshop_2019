//
//  UIView+Init.swift
//  UIKitLib
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

public extension IDP where Base: UIView {
    
    static func fromNib(owner: AnyObject) -> Base? {
        return self.fromNib(nibNameOrNil: nil, type: self.base, owner: owner)
    }
    
    static func fromNib(nibNameOrNil: String? = nil, owner: AnyObject? = nil) -> Base? {
        return self.fromNib(nibNameOrNil: nibNameOrNil, type: self.base, owner: owner)
    }
    
    static func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
        return self.fromNib(nibNameOrNil: nibNameOrNil, type: T.self, owner: nil)
    }
    
    static func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type, owner: AnyObject? = nil) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else if let nibName = self.nibName {
            name = nibName
        } else {
            return nil
        }

        let nibViews = Bundle.main.loadNibNamed(name, owner: owner, options: nil)
        view = nibViews?.filter{$0 is T}.first as? T

        return view
    }
    
    static var nibName: String? {
        return "\(Base.self)".components(separatedBy: ".").first
    }
    
    static var nib: UINib? {
        if let nibName = self.nibName,
            let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}
