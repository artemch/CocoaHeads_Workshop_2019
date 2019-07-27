//
//  ViewDataController.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 3/21/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

protocol ViewDataControllerType: class {
    
    associatedtype ViewData
    
    var viewData: ViewData { set get }
    
    init(viewData: ViewData)
}

class ViewDataController<ViewDataT>: UIViewController, ViewDataControllerType {

    typealias ViewData = ViewDataT
    
    var viewData: ViewData {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    // MARK: - Initializations and Deallocations
    
    required init(viewData: ViewData) {
        self.viewData = viewData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.render(viewData: self.viewData)
    }
    
    // MARK: - Private methods
    

    
    func render(viewData: ViewData) {
        
    }
}
