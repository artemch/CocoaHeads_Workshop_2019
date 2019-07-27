//
//  ResetPasswordPresentationModelImp.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/28/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveSwiftKit
import BackendServices
import Stores
import Result

public class ResetPasswordPresentationModelImp: ResetPasswordPresentationModel, ResetPasswordPresentationModelActionEvent {
    
    public var actionEvent: EventSignalType {
        return self.actionEventEmitter.event
    }
    
    public let data: Property<ViewData>
    
    // MARK: - Private properties
    
    private let actionEventEmitter = EventEmitter<EventSignalType.Value>()
    
    private let store: AuthenticationStoreProtocol
    
    private let emailError = MutableProperty<String?>(nil)
    
    private let dataInternal: MutableProperty<ViewData>
    
    private let (lifetime, token) = Lifetime.make()
    
    // MARK: - Initializations and Deallocations
    
    public init(store: AuthenticationStoreProtocol) {
        self.store = store
        let dataInternal = MutableProperty(ViewData.initial)
        self.dataInternal = dataInternal
        self.data = Property(capturing: dataInternal)
        self.updateViewData()
    }
    
    // MARK: - Private methods
    
    private func updateViewData() {
        self.store.model.producer
            .take(during: self.lifetime)
            .startWithValues { [weak self] model in
                let isLinkSent =  model.resetPassword.isLinkSent
                self?.dataInternal.value = ViewData(email: model.email,
                                                    state: model.resetPassword.loading.isLoading ? .inProgress : (isLinkSent ? .reset(command: { [weak self] in self?.signIn() }) : .notReset(command: { [weak self] in self?.resetPassword() })),
                                                    emailError: model.resetPassword.loading.errorReason,
                                                    onUpdateEmail: { [weak self] in self?.update(email: $0) },
                                                    onBack: { [weak self] in self?.back() })
        }
        
    }
    
    private func update(email: String) {
        self.store.update(email: email)
        self.store.clearResetPasswordError()
    }
    
    private func resetPassword() {
        self.store.resetPassword()
    }
    
    private func back() {
        self.store.clearResetPasword()
        self.actionEventEmitter.send(value: .back)
    }
    
    private func signIn() {
        self.actionEventEmitter.send(value: .signIn)
    }
}
