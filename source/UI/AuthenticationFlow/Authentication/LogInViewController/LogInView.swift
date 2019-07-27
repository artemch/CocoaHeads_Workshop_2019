import UIKit
import AppUIKit
import PresentationModels
import IDPDesign

class LogInView: UIView, ViewDataRenderableView {
    
    typealias ViewData = LoginWithEmailViewData
    
    @IBOutlet var logInButton: UIButton?
    
    @IBOutlet var noAccountButton: UIButton?
    
    @IBOutlet var forgotPasswordButton: UIButton?
    
    @IBOutlet var loginTextField: IDPTextField?
    
    @IBOutlet var passwordTextField: IDPTextField?
    
    weak var showPasswordButton: UIButton?
    
    private lazy var loadingView = IDPLoadingView(frame: self.bounds)
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let loginTextField = self.loginTextField
        let passwordTextField = self.passwordTextField
        let logInButton = self.logInButton
        let forgotPasswordButton = self.forgotPasswordButton
        let noAccountButton = self.noAccountButton
        
        loginTextField ?|> Styles.TextField.default()
            ?|> Styles.TextField.placeholder(placeholder: L10n.emailPlaceholder)
        
        passwordTextField ?|> Styles.TextField.default()
            ?|> Styles.TextField.placeholder(placeholder: L10n.passwordPlaceholder)
        
        logInButton ?|> Styles.Button.default()
            ?|> Styles.Button.title(title: L10n.login, for: .normal)
        
        forgotPasswordButton ?|> Styles.Button.forgotPassword()
            ?|> Styles.Button.title(title: L10n.forgotPassword, for: .normal)
        
        noAccountButton ?|> Styles.Button.default(style: .light)
            ?|> Styles.Button.title(title: L10n.doNotHaveAnAccount, for: .normal)
        
        loginTextField?.textContentType = .emailAddress
        passwordTextField?.textContentType = .password
        passwordTextField?.passwordRules = UITextInputPasswordRules(descriptor: F.passwordRulesDescriptor())
        
        self.configPasswordField()
        self.configEmailField()
    }
    
    // MARK: - ViewDataRenderableView
    
    func render(viewData: ViewData) {
        let loginTextField = self.loginTextField
        let passwordTextField = self.passwordTextField
        let loadingView = self.loadingView
        let isShowPassword = viewData.isShowPassword
        
        loginTextField?.text = viewData.login
        loginTextField?.errorText = viewData.emailError
        passwordTextField?.text = viewData.password
        passwordTextField?.errorText = viewData.passwordError
        passwordTextField?.isSecureTextEntry = !isShowPassword
        self.showPasswordButton?.isSelected = isShowPassword
        if viewData.isLoading {
            loadingView.show(on: self)
        } else {
            loadingView.hide()
        }
    }
    
    // MARK: - Private methods
    
    private func configEmailField() {
        let imageView = FUI.createEmailFieldRightView()
        self.loginTextField?.rightView = imageView
        self.loginTextField?.rightViewMode = .always
    }
    
    private func configPasswordField() {
        let showPasswordButton = FUI.createShowPasswordButton()
        self.showPasswordButton = showPasswordButton
        self.passwordTextField?.rightView = showPasswordButton
        self.passwordTextField?.rightViewMode = .always
    }
}
