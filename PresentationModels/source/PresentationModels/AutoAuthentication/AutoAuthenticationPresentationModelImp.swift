//
//  AutoAuthenticationPresentationModelImp.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import Services
import ReactiveSwift
import Result
import ReactiveSwiftKit
import ReactiveCocoa
import Stores

public class AutoAuthenticationPresentationModelImp: AutoAuthenticationPresentationModel, AutoAuthenticationPresentationModelActionEvent {
    
    public var actionEvent: EventSignalType {
        return self.actionEventEmitter.event
    }
    
    public let data: Property<ViewData>
    
    let dataInternal: MutableProperty<ViewData>
    
    let (lifetime, token) = Lifetime.make()
    
    // MARK: - Private properties
    
    private let actionEventEmitter = EventEmitter<EventSignalType.Value>()
    
    private let store: AuthenticationStoreProtocol
    
    // MARK: - Initializations and Deallocations
    
    public init(store: AuthenticationStoreProtocol) {
        self.store = store
        let dataInternal = MutableProperty(ViewData.initial)
        self.dataInternal = dataInternal
        self.data = Property(capturing: dataInternal)
        self.dataInternal.value = .auth(action: { [weak self] in self?.auth() })
    }
    
    // MARK: - Public methods
    
    private func auth() {
        self.dataInternal.value = .checking
        self.store
            .autoAuth()
            .take(during: self.lifetime)
            .observeOnMain()
            .startWithResult { [weak self] result in
                switch result {
                case .success(_):
                    self?.dataInternal.value = .authorized
                    self?.actionEventEmitter.send(value: .authenticated)
                case .failure:
                    self?.dataInternal.value = .notAuthorized
                    self?.actionEventEmitter.send(value: .notAuthenticated)
                }
        }
    }
}

