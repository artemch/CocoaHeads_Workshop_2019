//
//  TermsAndConditionsPresentationModelImp.swift
//  PresentationModels
//
//  Created by Artem Chabannyi on 3/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveSwiftKit
import Stores

public class TermsAndConditionsPresentationModelImp: TermsAndConditionsPresentationModel, TermsAndConditionsPresentationModelActionEvent {
    
    public var actionEvent: EventSignalType {
        return self.actionEventEmitter.event
    }
    
    // MARK: - Private properties
    
    private let store: AuthenticationStoreProtocol
    
    private let actionEventEmitter = EventEmitter<EventSignalType.Value>()
    
    // MARK: - Initializations and Deallocations
    
    public init(store: AuthenticationStoreProtocol) {
        self.store = store
        super.init(viewData: ViewData.initial)
        self.updateViewData()
    }
    
    // MARK: - Private methods
    
    private func updateViewData() {
        self.store
            .model
            .producer
            .take(during: self.lifetime)
            .startWithValues { [weak self] model in
                self?.dataInternal.value = TermsAndConditionsViewData(isAgree: model.isAgree,
                                                                      onBack: { [weak self] in self?.back()},
                                                                      onAgree: { [weak self] in self?.agree() })
        }
    }
    
    private func back() {
        self.actionEventEmitter.send(value: .back)
    }
    
    private func agree() {
        self.store.toggleIsAgree()
        self.actionEventEmitter.send(value: .agree)
    }
}
