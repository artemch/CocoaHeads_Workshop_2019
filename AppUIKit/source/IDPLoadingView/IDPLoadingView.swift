//
//  IDPLoadingView.swift
//  AppUIKit
//
//  Created by Artem Chabannyi on 3/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

public class IDPLoadingView: UIView {

    public let activityView = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: - Initializations and Deallocations
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.baseInit()
    }
    
    private func baseInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let activityView = self.activityView
        activityView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityView)
        activityView.center = self.center
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    // MARK: - Public methods
    
    public func start() {
        self.isHidden = false
        self.activityView.startAnimating()
    }
    
    public func stop() {
        self.activityView.stopAnimating()
        self.isHidden = true
    }
    
    public func show(on view: UIView) {
        self.removeFromSuperview()
        self.frame = view.bounds
        view.addSubview(self)
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.start()
    }
    
    public func hide(shouldRemove: Bool = true) {
        self.stop()
        if shouldRemove {
            self.removeFromSuperview()
        }
    }
}
