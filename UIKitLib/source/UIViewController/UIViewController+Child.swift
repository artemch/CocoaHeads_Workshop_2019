//
//  UIViewController+Child.swift
//  UIKitLib
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

public extension IDP where Base: UIViewController {
    func addChild(childController: UIViewController,
                  atView view: UIView,
                  atFrame frame:CGRect? = nil,
                  autoLayout: Bool = true) {
        let `self` = self.base
        
        self.addChild(childController)
        let rect = frame ?? view.bounds
        childController.view.frame = rect
        view.addSubview(childController.view)
        if autoLayout {
            let childView = childController.view
            childView?.translatesAutoresizingMaskIntoConstraints = false
            childView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            childView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            childView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            childView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        childController.didMove(toParent: self)
    }
    
    func addChild(childController: UIViewController,
                  atFrame frame:CGRect? = nil,
                  autoLayout: Bool = true) {
        self.addChild(childController: childController,
                      atView: self.base.view,
                      atFrame: frame,
                      autoLayout: autoLayout)
    }
    
    func removeChild(childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
}
