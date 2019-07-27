//
//  TermsAndConditionsPresentationModel.swift
//  PresentationModels
//
//  Created by Artem Chabannyi on 3/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public struct TermsAndConditionsViewData {
    public let isAgree: Bool
    public let onBack: (() -> ())?
    public let onAgree: (() -> ())?
    
    static var initial: TermsAndConditionsViewData {
        return TermsAndConditionsViewData(isAgree: false,
                                          onBack: nil,
                                          onAgree: nil)
    }
}

public class TermsAndConditionsPresentationModel: PresentationModelImp<TermsAndConditionsViewData> {
    
}
