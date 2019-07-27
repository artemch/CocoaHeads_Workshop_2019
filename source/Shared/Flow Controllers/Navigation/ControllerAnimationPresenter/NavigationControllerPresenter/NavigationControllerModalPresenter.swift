//
//  NavigationControllerModalPresenter.swift
//  AppArch
//
//  Created by Artem Chabannyi on 10/12/18.
//  Copyright © 2018 IDAP Group. All rights reserved.
//
import UIKit

public class NavigationControllerModalPresenter: NavigationControllerPresenter {
    
    public let controllerAnimatedTransitioning: NavigationCoordinatorAnimatorType?
    
    public let controllerInteractiveTransitioning: NavigationCoordinatorInteractiveAnimatorType?
    
    // MARK: - Initializations and Deallocations
    
    public init(controllerAnimatedTransitioning: NavigationCoordinatorAnimatorType?,
         controllerInteractiveTransitioning: NavigationCoordinatorInteractiveAnimatorType?)
    {
        self.controllerAnimatedTransitioning = controllerAnimatedTransitioning
        self.controllerInteractiveTransitioning = controllerInteractiveTransitioning
    }
}

extension NavigationControllerModalPresenter {
    public static var `default`: NavigationControllerModalPresenter {
        return NavigationControllerModalPresenter(controllerAnimatedTransitioning: ModalNavigationCoordinatorAnimator(transitionDuration: 0.3),
                                                  controllerInteractiveTransitioning: nil)
    }
}

public class ModalNavigationCoordinatorAnimator: NSObject, NavigationCoordinatorAnimatorType {
    
    public let transitionDuration: TimeInterval
    
    // MARK: - Private properties
    
    private var isPresenting: Bool = false
    
    // MARK: - Initializations and Deallocations
    
    public init(transitionDuration: TimeInterval) {
        self.transitionDuration = transitionDuration
    }
    
    // MARK: - ModalNavigationCoordinatorAnimatorType
    
    public func updateAnimationState(for operation: UINavigationController.Operation) {
        switch operation {
        case .push:
            self.isPresenting = true
        case .pop:
            self.isPresenting = false
        case .none:
            self.isPresenting = false
        }
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        let isPresenting = self.isPresenting
        
        container.addSubview(toView)
        toView.layoutIfNeeded()
        
        var fromViewFrame = fromView.frame
        var toViewFrame = toView.frame
        
        if isPresenting {
            toViewFrame.origin.y = container.bounds.height
            toView.frame = toViewFrame
            toViewFrame.origin.y = 0
        } else {
            fromViewFrame.origin.y = container.bounds.height
            container.bringSubviewToFront(fromView)
        }
        
        UIView.animate(withDuration: self.transitionDuration, animations: {
            fromView.frame = fromViewFrame
            toView.frame = toViewFrame
        }) { finished in
            if !isPresenting {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

