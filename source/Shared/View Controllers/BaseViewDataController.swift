//
//  BaseViewDataController.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/25/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit
import IDPRootViewGettable
import PresentationModels

class BaseViewDataController<Model: PresentationModel, View: UIView>: UIViewController, RootViewGettable
    where View: ViewDataRenderableView, Model.ViewData == View.ViewData
{
    typealias RootViewType = View
    
    typealias ViewData = Model.ViewData
    
    let presentationModel: Model
    
    var viewData: ViewData {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    // MARK: - Initializations and Deallocations
    
    init(presentationModel: Model,
         nibName nibNameOrNil: String? = nil,
         bundle nibBundleOrNil: Bundle? = nil)
    {
        self.presentationModel = presentationModel
        self.viewData = presentationModel.data.value
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.render(viewData: self.viewData)
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observePresentationModel()
    }
    
    // MARK: - Private methods
    
    func observePresentationModel() {
        self.presentationModel
            .data
            .producer
            .take(during: self.reactive.lifetime)
            .startWithValues { [weak self] value in
                self.do {
                    let oldViewData = $0.viewData
                    $0.willUpdate(viewData: $0.viewData, newViewData: oldViewData)
                    $0.viewData = value
                    $0.didUpdate(viewData: value, oldViewData: oldViewData)
                }
        }
    }
    
    func render(viewData: Model.ViewData) {
        self.rootView?.render(viewData: self.viewData)
    }
    
    func willUpdate(viewData: ViewData, newViewData: ViewData) {
        
    }
    
    func didUpdate(viewData: ViewData, oldViewData: ViewData) {
        
    }
}
