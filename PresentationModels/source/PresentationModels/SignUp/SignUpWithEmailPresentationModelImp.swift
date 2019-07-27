//
//  SignUpWithEmailPresentationModelImp.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/26/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Services
import Models
import Validators
import ReactiveSwiftKit
import BackendServices
import Stores
import SharedLocalization

public class SignUpWithEmailPresentationModelImp: PresentationModelImp<SignUpWithEmailViewData>, SignUpWithEmailPresentationModel, SignUpWithEmailPresentationModelActionEvent {
    
    typealias Error = StoreError
    
    public var actionEvent: EventSignalType {
        return self.actionEventEmitter.event
    }
    
    // MARK: - Private properties
    
    private let store: AuthenticationStoreProtocol
    
    private let emailError = MutableProperty<String?>(nil)
    
    private let passwordError = MutableProperty<String?>(nil)
    
    private let isShowPassword = MutableProperty<Bool>(false)
    
    private let actionEventEmitter = EventEmitter<EventSignalType.Value>()
    
    private let isLoading = MutableProperty(false)
    
    private let fullNameError = MutableProperty<String?>(nil)
    
    private let isAgreeError = MutableProperty<String?>(nil)
    
    private let alertError = MutableProperty<AlertError?>(nil)
    
    // MARK: - Initializations and Deallocations
    
    public init(store: AuthenticationStoreProtocol)
    {
        self.store = store
        super.init(viewData: ViewData.initial)
        self.updateViewData()
    }
    
    // MARK: - Private methods
    
    private func updateViewData() {
        let store = self.store
        let result = SignalProducer.combineLatest(store.model.producer,
                                                  self.emailError.producer,
                                                  self.passwordError.producer,
                                                  self.isShowPassword.producer,
                                                  self.isLoading.producer,
                                                  self.fullNameError.producer,
                                                  self.isAgreeError.producer,
                                                  self.alertError.producer)
        result
            .take(during: self.lifetime)
            .startWithValues { [weak self] values in
                let (model,
                emailError,
                passwordError,
                isShowPassword,
                isLoading,
                fullNameError,
                isAgreeError,
                alertError) = values
                self?.dataInternal.value = ViewData(email: model.email,
                                                    password: model.password,
                                                    isAgree: model.isAgree,
                                                    emailError: emailError,
                                                    passwordError: passwordError,
                                                    isAgreeError: isAgreeError,
                                                    isShowPassword: isShowPassword,
                                                    isLoading: isLoading,
                                                    fullName: model.displayName,
                                                    fullNameError: fullNameError,
                                                    alertError: alertError,
                                                    onSignUp: { [weak self] in self?.signUp() },
                                                    onUpdatePassword: { [weak self] (text) in self?.update(password: text) },
                                                    onUpdateLogin: { [weak self] (text) in self?.update(email: text) },
                                                    onAgree: { [weak self] in self?.agree() },
                                                    back: { [weak self] in self?.back() },
                                                    onHaveAccount: { [weak self] in self?.haveAccount() },
                                                    onTermsAndConditions: { [weak self] in self?.termsAndConditions() },
                                                    onShowPassword: { [weak self] in self?.showPassword() },
                                                    onUpdateFullName: { [weak self] in self?.update(fullName: $0) })
                self?.checkIsAgreeState(isAgree: model.isAgree, isAgreeError: isAgreeError)
        }
    }
    
    private func checkIsAgreeState(isAgree: Bool, isAgreeError: String?) {
        if isAgree && isAgreeError != nil {
            DispatchQueue.main.async {
                self.isAgreeError.value = nil
            }
        }
    }
    
    private func signUp() {
        self.isLoading.value = true
        self.store
            .signUpWithEmail()
            .take(during: self.lifetime)
            .observeOnMain()
            .startWithResult { [weak self] result in
                self?.isLoading.value = false
                switch result {
                case .success(_):
                    self?.actionEventEmitter.send(value: .signedUp)
                case .failure(let error):
                    self?.update(error: error)
                }
        }
    }
    
    private func update(error: Error) {
        switch error {
        case .error(let reason):
            self.update(error: nil)
            self.alertError.value = AlertError(title: nil,
                                               message: reason,
                                               actions: [AlertErrorAction(title: L10n.Localization.ok, style: .default, action: { [weak self] in self?.updateAlertError() })])
        case .invalidFields(let fields):
            self.update(error: fields)
            self.alertError.value = nil
        }
    }
    
    private func updateAlertError() {
        self.alertError.value = nil
    }
    
    private func update(error: FieldsError?) {
        self.emailError.value = error?.email
        self.passwordError.value = error?.password
        self.fullNameError.value = error?.displayName
        self.isAgreeError.value = error?.isAgree
    }
    
    private func update(email: String) {
        self.store.update(email: email)
        self.emailError.value = nil
    }
    
    private func update(password: String) {
        self.store.update(password: password)
        self.passwordError.value = nil
    }
    
    private func agree() {
        self.isAgreeError.value = nil
        self.store.toggleIsAgree()
    }
    
    private func showPassword() {
        self.isShowPassword.value = !self.isShowPassword.value
    }
    
    private func back() {
        self.store.clearPassword()
        self.actionEventEmitter.send(value: .back)
    }
    
    private func haveAccount() {
        self.actionEventEmitter.send(value: .haveAccount)
    }
    
    private func termsAndConditions() {
        self.actionEventEmitter.send(value: .termsAndConditions)
    }
    
    private func update(fullName: String?) {
        self.fullNameError.value = nil
        self.store.update(fullName:fullName)
    }
}
