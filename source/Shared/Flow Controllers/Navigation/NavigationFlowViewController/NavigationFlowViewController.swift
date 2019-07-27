//
//  NavigationFlowViewController.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/8/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveSwiftKit

public class NavigationFlowViewController<Presenter: NavigationControllerPresenter, EventAction: FlowEventAction>: UINavigationController, FlowViewControllerOutEvent, UINavigationControllerDelegate {
    
    public typealias EventEmitter = ReactiveSwiftKit.EventEmitter<EventAction>
    
    // MARK: - Public properties
    
    public var event: EventEmitter.EventSignal {
        return self.eventEmitter.event
    }
    
    // MARK: - Private methods
    
    private let eventEmitter = EventEmitter()
    
    public let presenter: Presenter
    
    // MARK: - Initializations and Deallocations
    
    public init(presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not allowed.")
    }
    
    // MARK: - Public methods
    
    public func send(action: EventAction) {
        self.eventEmitter.send(value: action)
    }
    
    // MARK: - UINavigationControllerDelegate
    
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let controllerAnimatedTransitioning = self.presenter.controllerAnimatedTransitioning
        controllerAnimatedTransitioning?.updateAnimationState(for: operation)
        return controllerAnimatedTransitioning

    }
    

    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.presenter.controllerInteractiveTransitioning
    }
}
