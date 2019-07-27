import UIKit
import GoogleSignInProvider
import ReactiveCocoa
import ReactiveSwift
import IQKeyboardManager
import Models
import PresentationModels
import Stores
import Fabric
import Crashlytics
import Services

enum AppFlowViewControllerN {
    enum EventAction: FlowEventAction { }
}

class AppFlowViewController: NavigationFlowViewController<NavigationControllerModalPresenter, AppFlowViewControllerN.EventAction> {
    
    public let factoryLocator: FactoryLocator
    
    private let googleSignInProvider: GoogleSignInProvider
    
    private let appServiceLocator: AppServiceLocator
    
    lazy private var authorizedServiceLocator: AuthorizedServiceLocator = { [unowned self] in
        return AuthorizedServiceLocatorImp(appServiceLocator: self.appServiceLocator,
                                           factoryLocator: self.factoryLocator)
    }()
    
    // MARK: - Initializations and Deallocations
    
    public init() {
        let factoryLocator = FactoryLocator.default()
        let googleSignInProvider = GoogleSignInProvider(clientID: factoryLocator.appConfigFactory.defaultAppConfig.googleClientId)
        self.googleSignInProvider = googleSignInProvider
        self.factoryLocator = factoryLocator
        self.appServiceLocator = AppServiceLocatorImp(factoryLocator: factoryLocator,
                                                      googleSignInProvider: googleSignInProvider)
        super.init(presenter: NavigationControllerModalPresenter.default)
        self.config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
        self.showAuthenticationFlow(mode: .autoAuth)
    }
    
    // MARK: - Private methods
    
    private func showAuthenticationFlow(mode: AuthenticationFlowViewController.Mode) {
        let authenticationServiceLocator = AuthenticationServiceLocatorImp(appServiceLocator: self.appServiceLocator,
                                                                           factoryLocator: self.factoryLocator )
        let flowViewController = AuthenticationFlowViewController(serviceLocator: authenticationServiceLocator,
                                                                  mode: mode)
        flowViewController
            .event
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .authenticated(let authResult):
                    self?.showAuthorizedFlow(authResult: authResult)
                }
        }
        self.setViewControllers([flowViewController], animated: false)
    }
    
    private func showAuthorizedFlow(authResult: AuthResult) {
        let serviceLocator = AuthorizedServiceLocatorImp(appServiceLocator: self.appServiceLocator,
                                                             factoryLocator: self.factoryLocator)
        let store = AuthorizedStore(authResult: authResult,
                                    logOutService: self.authorizedServiceLocator.logOutService)
        let flowViewController = AuthorizedFlowViewController(serviceLocator: serviceLocator,
                                                              store: store)
        flowViewController
            .event
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .logOut:
                    self?.showAuthenticationFlow(mode: .authentication)
                }
        }
        self.setViewControllers([flowViewController], animated: false)
    }
}

extension AppFlowViewController {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return self.googleSignInProvider.provider(open: url, options: options)
    }
}

fileprivate extension AppFlowViewController {
    func config() {
        if self.factoryLocator.appConfigFactory.defaultAppConfig.isFirstRun {
            self.appServiceLocator.securityService.removeUserAuthToken().start()
        }
        self.configKeyboard()
        self.configNavControllerAppearance()
    }
}

fileprivate extension AppFlowViewController {
    func configKeyboard() {
        let keyboardManager = IQKeyboardManager.shared()
        keyboardManager.isEnabled = false
        keyboardManager.isEnableAutoToolbar = false
        keyboardManager.shouldShowToolbarPlaceholder = false
        keyboardManager.toolbarDoneBarButtonItemText = L10n.done
        keyboardManager.shouldResignOnTouchOutside = true
    }
}

fileprivate extension AppFlowViewController {
    func configNavControllerAppearance() {
        let font = UIFont.systemFont(ofSize: 17, weight: .regular)
        let titleTextAttributes = [NSAttributedString.Key.font : font,
                                   NSAttributedString.Key.foregroundColor: UIColor(named: .black)]
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor(named: .tealish)
        navigationBarAppearance.titleTextAttributes = titleTextAttributes
        navigationBarAppearance.barTintColor = UIColor(named: .white)
        
        let barButtonAttributes = [NSAttributedString.Key.font : font,
                                   NSAttributedString.Key.foregroundColor: UIColor(named: .tealish)]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
            .setTitleTextAttributes(barButtonAttributes, for: .normal)
    }
}
