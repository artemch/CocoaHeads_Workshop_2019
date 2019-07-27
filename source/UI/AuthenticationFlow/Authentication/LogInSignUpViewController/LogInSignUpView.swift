import UIKit
import FoundationKit
import PresentationModels
import IDPDesign
import AppUIKit

class LogInSignUpView: UIView, ViewDataRenderableView {
    
    typealias ViewData = SignInSignUpViewData
    
    @IBOutlet var logInButton: UIButton?
    
    @IBOutlet var signUpButton: UIButton?
    
    @IBOutlet var titleLabel: UILabel?
    
    @IBOutlet var textLabel: UILabel?
    
    @IBOutlet var loadingView: IDPLoadingView?
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let logInButton = self.logInButton
        let signUpButton = self.signUpButton
        let titleLabel = self.titleLabel
        let textLabel = self.textLabel
        
        logInButton?.setTitle(L10n.login, for: .normal)
        signUpButton?.setTitle(L10n.signup, for: .normal)
        titleLabel?.text = L10n.signupSigninTitleMessage
        textLabel?.text = L10n.signupSigninWelcomeMessage
        
        logInButton ?|> Styles.Button.default()
        signUpButton ?|> Styles.Button.default()
        titleLabel ?|> F.titleStyle()
        textLabel ?|> F.textStyle()
    }
    
    // MARK: - ViewDataRenderableView
    
    func render(viewData: ViewData) {
        let loadingView = self.loadingView
        
        if viewData.isLoading {
            loadingView?.start()
        } else {
            loadingView?.stop()
        }
    }
}

fileprivate extension LogInSignUpView {
    enum F { }
}

fileprivate extension LogInSignUpView.F {
    static func titleStyle() -> Style<UILabel> {
        return design(
            Styles.Label.bold(fontSize: 20),
            textColor ~ UIColor(named: .black)
        )
    }
    
    static func textStyle() -> Style<UILabel> {
        return design(
            Styles.Label.regular(fontSize: 14),
            textColor ~ UIColor(named: .black)
        )
    }
}
