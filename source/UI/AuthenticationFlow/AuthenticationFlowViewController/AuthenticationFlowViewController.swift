import UIKit
import ReactiveSwift
import Services
import GoogleSignInProvider
import ReactiveCocoa
import Models
import PresentationModels
import Stores

enum AuthenticationFlowViewControllerN {
    public enum EventAction: FlowEventAction  {
        case authenticated(AuthResult)
    }
}

class AuthenticationFlowViewController: NavigationControllerContainer<NavigationControllerDefaultPresenter, AuthenticationFlowViewControllerN.EventAction> {
    
    enum Mode {
        case autoAuth
        case authentication
    }
    
    // MARK: - Private properties
    
    private let serviceLocator: AuthenticationServiceLocator
    
    private let mode: Mode
    
    private let store: AuthenticationStoreProtocol
    
    // MARK: - Initializations and Deallocations
    
    public init(serviceLocator: AuthenticationServiceLocator,
                mode: Mode) {
        self.mode = mode
        self.serviceLocator = serviceLocator
        self.store = AuthenticationStore(loginService: serviceLocator.loginService,
                                         signUpService: serviceLocator.signUpService,
                                         autoAuthService: serviceLocator.autoAuthenticationService,
                                         resetPasswordService: serviceLocator.resetPasswordBackendService())
        super.init(presenter: NavigationControllerDefaultPresenter())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Snippet: AFC_1
        switch self.mode {
        case .autoAuth:
            self.showAutoAuth()
        case .authentication:
            self.showLogInSignUp()
        }
    }
    
    // MARK: - Private methods
    
    private func showLogIn() {
        //Snippets AFC_2_1 - 2_4
        let presentationModel = LoginWithEmailPresentationModelImp(store: self.store)
        let viewController = LogInViewController(presentationModel: presentationModel)
        presentationModel
            .actionEvent
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .loggedIn:
                    self?.authenticated()
                case .back:
                    self?.popViewController(animated: true)
                    self?.contentController.setNavigationBarHidden(true, animated: false)
                case .resetPassword:
                    self?.showResetPassword()
                case .doNotHaveAccount:
                    self?.showSignUp()
                }
        }
        self.pushViewControllerOnTopOfRoot(viewController, animated: true)
        self.contentController.setNavigationBarHidden(false, animated: false)
    }
    
    private func authenticated() {
        if let authResult = self.store.model.value.authResult {
            self.send(action: .authenticated(authResult))
        }
    }
    
    private func showAutoAuth() {
        let presentationModel = AutoAuthenticationPresentationModelImp(store: self.store)
        let viewController = AutoAuthenticationViewController(presentationModel: presentationModel)
        presentationModel
            .actionEvent
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .authenticated:
                    self?.authenticated()
                case .notAuthenticated:
                    self?.showLogInSignUp()
                }
        }
        self.pushViewController(viewController, animated: false)
    }
    
    private func showLogInSignUp() {
        let presentationModel = SignInSignUpPresentationModelImp(store: self.store)
        let viewController = LogInSignUpViewController(presentationModel: presentationModel,
                                                       googleUISignInProvider: self.serviceLocator.googleUISignInProvider)
        presentationModel
            .actionEvent
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .logIn:
                    self?.showLogIn()
                case .signUp:
                    self?.showSignUp()
                case .signInGoogle:
                    self?.authenticated()
                }
        }
        self.setViewControllers([viewController], animated: false)
    }
    
    private func showSignUp() {
        let presentationModel = SignUpWithEmailPresentationModelImp(store: self.store)
        let viewController = SignUpViewController(presentationModel: presentationModel)
        presentationModel
            .actionEvent
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .back:
                    self?.popViewController(animated: true)
                    self?.contentController.setNavigationBarHidden(true, animated: false)
                case .signedUp:
                    self?.authenticated()
                case .haveAccount:
                    self?.showLogIn()
                case .termsAndConditions:
                    self?.showTermsAndConditions()
                    break
                }
        }
        self.pushViewControllerOnTopOfRoot(viewController, animated: true)
        self.contentController.setNavigationBarHidden(false, animated: false)
    }
    
    private func showResetPassword() {
        let presentationModel = ResetPasswordPresentationModelImp(store: self.store)
        let viewController = ResetPasswordViewController(presentationModel: presentationModel)
        presentationModel
            .actionEvent
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .back:
                    self?.popViewController(animated: true)
                case .signIn:
                    self?.showLogIn()
                }
        }
        
        self.pushViewController(viewController, animated: true)
    }
    
    private func showTermsAndConditions() {
        let presentationModel = TermsAndConditionsPresentationModelImp(store: self.store)
        let viewController = TermsAndConditionsViewController(presentationModel: presentationModel)
        presentationModel
            .actionEvent
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .back, .agree:
                    self?.popViewController(animated: true)
                }
        }
        self.pushViewController(viewController, animated: true)
    }
}
