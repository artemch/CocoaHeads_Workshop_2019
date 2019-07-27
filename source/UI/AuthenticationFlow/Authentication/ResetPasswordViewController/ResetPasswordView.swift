import UIKit
import AppUIKit
import PresentationModels
import IDPDesign

class ResetPasswordView: UIView, ViewDataRenderableView {
    
    typealias ViewData = ResetPasswordViewData
    
    @IBOutlet var resetPasswordButton: UIButton?
    
    @IBOutlet var signInButton: UIButton?
    
    @IBOutlet var textLabel: KTGLabel?
    
    @IBOutlet var emailTextField: IDPTextField?
    
    lazy var loadingView = IDPLoadingView()
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let resetPasswordButton = self.resetPasswordButton
        let signInButton = self.signInButton
        let emailTextField = self.emailTextField
        let textLabel = self.textLabel
        
        resetPasswordButton ?|> Styles.Button.default()
        signInButton ?|> Styles.Button.default()
        emailTextField ?|> Styles.TextField.default()
        textLabel ?|> F.resetTextLabel()
        
        resetPasswordButton?.setTitle(L10n.resetPassword, for: .normal)
        signInButton?.setTitle(L10n.login, for: .normal)
        emailTextField?.rightView = FUI.createEmailFieldRightView()
        emailTextField?.rightViewMode = .always
        emailTextField?.textContentType = .emailAddress
        textLabel?.inset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        textLabel?.text = L10n.resetPasswordResultTitle
    }
    
    // MARK: - ViewDataRenderableView
    
    func render(viewData: ViewData) {
        let state = viewData.state
        let isReset = state.isReset
        let emailTextField = self.emailTextField
        let loadingView = self.loadingView
        
        emailTextField?.text = viewData.email
        emailTextField?.errorText = viewData.emailError
        self.textLabel?.isHidden = !isReset
        self.resetPasswordButton?.isHidden = isReset
        self.signInButton?.isHidden = !isReset
        
        switch state {
        case .inProgress:
            loadingView.show(on: self)
        case .notReset, .reset:
            loadingView.stop()
        }
    }
}

fileprivate extension ResetPasswordView {
    enum F {}
}

fileprivate extension ResetPasswordView.F {
    static func resetTextLabel() -> Style<UILabel> {
        return design(
            Styles.Label.light(fontSize: 14),
            textColor ~ UIColor(named: .black)
        )
    }
}

