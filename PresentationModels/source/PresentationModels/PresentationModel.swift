//
//  PresentationModel.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/25/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public protocol PresentationModel: class {
    associatedtype ViewData
    var data: Property<ViewData> { get }
}

public protocol ViewDataRenderableView: class {
    
    associatedtype ViewData
    
    func render(viewData: ViewData)
}
