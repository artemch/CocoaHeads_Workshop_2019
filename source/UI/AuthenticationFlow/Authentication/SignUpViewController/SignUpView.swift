import UIKit
import AppUIKit
import PresentationModels

class SignUpView: UIView, ViewDataRenderableView {
    
    typealias ViewData = SignUpWithEmailViewData
    
    @IBOutlet var fullNameTextField: IDPTextField?
    
    @IBOutlet var loginTextField: IDPTextField?
    
    @IBOutlet var passwordTextField: IDPTextField?
    
    @IBOutlet var signUpButton: UIButton?
    
    @IBOutlet var haveAccountButton: UIButton?
    
    @IBOutlet var agreeButton: UIButton?
    
    @IBOutlet var agreeLabel: UILabel?
    
    @IBOutlet var isAgreeErrorLabel: UILabel?
    
    weak var showPasswordButton: UIButton?
    
    weak var clearFullNameButton: UIButton? {
        return self.fullNameTextField?.rightView as? UIButton
    }
    
    private lazy var loadingView = IDPLoadingView(frame: self.bounds)

    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let loginTextField = self.loginTextField
        let passwordTextField = self.passwordTextField
        let haveAccountButton = self.haveAccountButton
        let signUpButton = self.signUpButton
        let fullNameTextField = self.fullNameTextField
        
        loginTextField ?|> Styles.TextField.default()
        passwordTextField ?|> Styles.TextField.default()
        haveAccountButton ?|> Styles.Button.default(style: .light)
        signUpButton ?|> Styles.Button.default()
        fullNameTextField ?|> Styles.TextField.default()
        
        loginTextField?.placeholder = L10n.emailPlaceholder
        passwordTextField?.placeholder = L10n.passwordPlaceholder
        haveAccountButton?.setTitle(L10n.haveAnAccount, for: .normal)
        signUpButton?.setTitle(L10n.signup, for: .normal)
        fullNameTextField?.placeholder = L10n.fullNamePlaceholder
        
        loginTextField?.textContentType = .emailAddress
        passwordTextField?.textContentType = .newPassword
        passwordTextField?.passwordRules = UITextInputPasswordRules(descriptor: F.passwordRulesDescriptor())
        
        self.configAgreeLabel()
        self.configEmailField()
        self.configPasswordField()
        self.configFullNameField()
    }
    
    // MARK: - ViewDataRenderableView
    
    func render(viewData: ViewData) {
        let loginTextField = self.loginTextField
        let passwordTextField = self.passwordTextField
        let fullNameTextField = self.fullNameTextField
        let loadingView = self.loadingView
        let agreeButton = self.agreeButton
        let showPasswordButton = self.showPasswordButton
        let isAgreeErrorLabel = self.isAgreeErrorLabel
        
        loginTextField?.text = viewData.email
        loginTextField?.errorText = viewData.emailError
        passwordTextField?.text = viewData.password
        passwordTextField?.errorText = viewData.passwordError
        agreeButton?.isSelected = viewData.isAgree
        fullNameTextField?.text = viewData.fullName
        fullNameTextField?.errorText = viewData.fullNameError
        passwordTextField?.isSecureTextEntry = !viewData.isShowPassword
        showPasswordButton?.isSelected = viewData.isShowPassword
        if viewData.isLoading {
            loadingView.show(on: self)
        } else {
            loadingView.hide()
        }
        isAgreeErrorLabel?.isHidden = viewData.isAgreeError == nil
        isAgreeErrorLabel?.text = viewData.isAgreeError
    }
    
    // MARK: - Private methods
    
    private func configAgreeLabel() {
        let termsAndConditions = L10n.termsAndConditions
        let fullString = L10n.agreeToAll(termsAndConditions)
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
            .foregroundColor: UIColor(named: .black)
        ]
        
        let attributedString = NSMutableAttributedString(string: fullString, attributes: attributes)
        let range = (fullString as NSString).range(of: termsAndConditions)
        attributedString.addAttributes([
            .foregroundColor: UIColor(named: .tealish),
            .underlineColor: UIColor(named: .tealish),
            .underlineStyle: NSUnderlineStyle.single.rawValue
            ], range: range)
        self.agreeLabel?.attributedText = attributedString
    }
    
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
    
    private func configFullNameField() {
        self.fullNameTextField?.rightView = FUI.createFullNameFieldRightButton()
        self.fullNameTextField?.rightViewMode = .always
    }
}
