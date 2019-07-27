import UIKit
import Stores
import PresentationModels

enum ProfileFlowViewControllerN {
    enum EventAction: FlowEventAction {
        case logOut
    }
}

class ProfileFlowViewController: NavigationControllerContainer<NavigationControllerModalPresenter, ProfileFlowViewControllerN.EventAction> {
    
    // MARK: - Private properties
    
    private let serviceLocator: AuthorizedServiceLocator
    
    private let authStore: AuthorizedStoreProtocol
    
    // MARK: - Initializations and Deallocations
    
    init(serviceLocator: AuthorizedServiceLocator,
         authStore: AuthorizedStoreProtocol)
    {
        self.authStore = authStore
        self.serviceLocator = serviceLocator
        super.init(presenter: NavigationControllerModalPresenter.default)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupProfileViewController()
    }
    
    // MARK: - Private methods
    
    private func setupProfileViewController() {
        let authStore = self.authStore
        let presentationModel = ProfilePresentationModelImp(store: authStore)
        let viewController = ProfileViewController(presentationModel: presentationModel)
        presentationModel
            .actionEvent
            .take(during: self.reactive.lifetime)
            .observeValues { [weak self] event in
                switch event {
                case .logOut:
                    self?.send(action: .logOut)
                }
        }
        self.contentController.setViewControllers([viewController], animated: false)
    }
}
