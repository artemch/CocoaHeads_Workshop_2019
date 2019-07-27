//
//  NavigationControllerPresenter.swift
//  AppArch
//
//  Created by Artem Chabannyi on 10/12/18.
//  Copyright © 2018 IDAP Group. All rights reserved.
//
import UIKit

public protocol NavigationControllerPresenter {
    
    var controllerAnimatedTransitioning: NavigationCoordinatorAnimatorType? { get }
    
    var controllerInteractiveTransitioning: NavigationCoordinatorInteractiveAnimatorType? { get }
}

public protocol NavigationCoordinatorAnimatorType: class, UIViewControllerAnimatedTransitioning {
    func updateAnimationState(for operation: UINavigationController.Operation)
}

public protocol NavigationCoordinatorInteractiveAnimatorType: class, UIViewControllerInteractiveTransitioning {
    
}


