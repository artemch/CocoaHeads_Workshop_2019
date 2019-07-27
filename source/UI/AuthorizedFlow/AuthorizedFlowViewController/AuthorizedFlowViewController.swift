import UIKit
import ReactiveSwift
import ReactiveCocoa
import Models
import PresentationModels
import Stores
import IDPDesign

enum AuthorizedFlowViewControllerN {
    enum EventAction: FlowEventAction {
        case logOut
    }
}

class AuthorizedFlowViewController: NavigationControllerContainer<NavigationControllerModalPresenter, AuthorizedFlowViewControllerN.EventAction> {

    private enum TabBarItem: Int {
        case profile
    }
    
    private let serviceLocator: AuthorizedServiceLocator
    
    private var tabBarViewController: UITabBarController?
    
    private let store: AuthorizedStoreProtocol
    
    // MARK: - Initializations and Deallocations
    
    public init(serviceLocator: AuthorizedServiceLocator, store: AuthorizedStoreProtocol) {
        self.serviceLocator = serviceLocator
        self.store = store
        super.init(presenter: NavigationControllerModalPresenter.default)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentController.setNavigationBarHidden(true, animated: false)
        self.setupTabBarViewController()
    }
    
    // MARK: - Private methods
    
    private func setupTabBarViewController() {
        let tabBarViewController = UITabBarController()
        self.tabBarViewController = tabBarViewController
        let vc1 = self.profileViewController()
        tabBarViewController.setViewControllers([vc1], animated: false)
        self.setViewControllers([tabBarViewController], animated: false)
    }
    
    private func profileViewController() -> UIViewController {
        let viewController = ProfileFlowViewController(serviceLocator: self.serviceLocator,
                                                       authStore: self.store)
        viewController.tabBarItem = UITabBarItem(title: L10n.tabBarProfile,
                                                 image: UIImage(named: "profile_tab_icon")?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(named: "profile_tab_icon_selected")?.withRenderingMode(.alwaysOriginal))
        viewController
            .event
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .logOut:
                    self?.send(action: .logOut)
                }
        }
        return viewController
    }
}
