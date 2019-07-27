import ReactiveSwift
import Models

//sourcery: AutoMockable
public protocol AuthenticationStoreProtocol: class {
    
    typealias Model = AuthenticationStoreDomain.Model
    
    var model: MutableProperty<Model> { get }
    
    func clearPassword()
    
    func clearEmail()
    
    func update(email: String)
    
    func update(password: String)
    
    func toggleIsAgree()
    
    func update(fullName: String?)
    
    func autoAuth() -> SignalProducer<AuthResult, StoreError>
    
    func signInWithEmail() -> SignalProducer<AuthResult, StoreError>
    
    func signUpWithEmail() -> SignalProducer<AuthResult, StoreError>
    
    func signInWithGoogle() -> SignalProducer<AuthResult, StoreError>
    
    func resetPassword()
    
    func clearResetPasword()
    
    func clearResetPasswordError()
    
}
