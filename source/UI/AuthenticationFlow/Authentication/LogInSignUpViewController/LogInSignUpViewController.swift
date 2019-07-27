import UIKit
import FoundationKit
import Services
import GoogleSignInProvider
import PresentationModels
import UIKitLib

class LogInSignUpViewController<Model: SignInSignUpPresentationModel>: BaseViewDataController<Model, LogInSignUpView> {
    
    private let googleUISignInProvider: GoogleUISignInProvider
    
    // MARK: - Initializations and Deallocations
    
    init(presentationModel: Model,
        googleUISignInProvider: GoogleUISignInProvider)
    {
        self.googleUISignInProvider = googleUISignInProvider
        super.init(presentationModel: presentationModel,
                   nibName: nibNameForViewController(type: LogInSignUpViewController.self),
                   bundle: nil)
        self.configGoogleUIProvider()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interface Handling
    
    @IBAction func onLogIn(_ sender: UIButton) {
        self.viewData.onSignIn?()
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        self.viewData.onSignUp?()
    }
    
    // MARK: - Private methods
    
    private func configGoogleUIProvider() {
        let googleUISignInProvider = self.googleUISignInProvider
        googleUISignInProvider.signPresentViewController = { [weak self] viewController in
            self?.present(viewController, animated: true)
        }
        
        googleUISignInProvider.signDismissViewController = { viewController in
            viewController.dismiss(animated: true)
        }
    }
}
