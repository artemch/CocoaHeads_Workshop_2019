//
//  PresentationModelImp.swift
//  PresentationModels
//
//  Created by Artem Chabannyi on 3/12/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public class PresentationModelImp<ViewData>: PresentationModel {
    
    public let data: Property<ViewData>
    
    let dataInternal: MutableProperty<ViewData>
    
    let (lifetime, token) = Lifetime.make()
    
    // MARK: - Initializations and Deallocations
    
    init(viewData: ViewData) {
        let dataInternal = MutableProperty(viewData)
        self.dataInternal = dataInternal
        self.data = Property(capturing: dataInternal)
    }
    
}
