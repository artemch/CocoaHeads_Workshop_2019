//
//  SignInSignUpPresentationModelImp.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Models
import Services
import ReactiveSwiftKit
import Stores

public class SignInSignUpPresentationModelImp: PresentationModelImp<SignInSignUpViewData>, SignInSignUpPresentationModel, SignInSignUpPresentationModelActionEvent {
    
    public var actionEvent: EventSignalType {
        return self.actionEventEmitter.event
    }
    
    // MARK: - Private properties
    
    private let actionEventEmitter = EventEmitter<EventSignalType.Value>()
    
    private let store: AuthenticationStoreProtocol
    
    private let isLoading = MutableProperty(false)
    
    // MARK: - Initializations and Deallocations
    
    public init(store: AuthenticationStoreProtocol)
    {
        self.store = store
        super.init(viewData: ViewData.initial)
        self.updateViewData()
    }
    
    // MARK: - Private methods
    
    private func updateViewData() {
        self.isLoading
            .producer
            .take(during: self.lifetime)
            .startWithValues { [weak self] isLoading in
                self?.dataInternal.value = ViewData(isLoading: isLoading,
                                                    onSignIn: { [weak self] in self?.signIn() },
                                                    onSignUp: { [weak self] in self?.signUp() })
        }
        
    }
    
    private func signIn() {
        self.actionEventEmitter.send(value: .logIn)
    }
    
    private func signUp() {
        self.actionEventEmitter.send(value: .signUp)
    }
}
