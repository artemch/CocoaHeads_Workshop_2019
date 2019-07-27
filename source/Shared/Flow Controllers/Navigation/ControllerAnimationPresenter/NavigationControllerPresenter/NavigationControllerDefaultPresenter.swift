//
//  NavigationControllerDefaultPresenter.swift
//  AppArch
//
//  Created by Artem Chabannyi on 10/12/18.
//  Copyright © 2018 IDAP Group. All rights reserved.
//
import UIKit

public class NavigationControllerDefaultPresenter: NavigationControllerPresenter {
    
    public let controllerAnimatedTransitioning: NavigationCoordinatorAnimatorType?
    
    public let controllerInteractiveTransitioning: NavigationCoordinatorInteractiveAnimatorType?
    
    // MARK: - Initializations and Deallocations
    
    public init() {
        self.controllerAnimatedTransitioning = nil
        self.controllerInteractiveTransitioning = nil
    }
}

extension NavigationControllerDefaultPresenter {
    public static var `default`: NavigationControllerDefaultPresenter {
        return NavigationControllerDefaultPresenter()
    }
}
