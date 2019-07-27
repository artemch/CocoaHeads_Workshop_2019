import UIKit
import PresentationModels
import UIKitLib

class ResetPasswordViewController<Model: ResetPasswordPresentationModel>: BaseViewDataController<Model, ResetPasswordView>, UITextFieldDelegate, KeyboardFocusViewController {

    // MARK: - Initializations and Deallocations
    
    init(presentationModel: Model) {
        super.init(presentationModel: presentationModel,
                   nibName: nibNameForViewController(type: ResetPasswordViewController.self),
                   bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enableKeyboardFocus()
        self.setupNavBar()
    }
    
    // MARK: - Interface Handling
    
    @IBAction func onResetPassword(_ sender: UIButton) {
        if case .notReset(let command) = self.viewData.state {
            command?()
        }
    }
    
    @IBAction func onSignIn(_ sender: UIButton) {
        if case .reset(let command) = self.viewData.state {
            command?()
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        self.viewData.onUpdateEmail?(textField.text ?? "")
    }
    
    // MARK: - Private methods
    
    fileprivate func setupNavBar() {
        self.title = L10n.resetPasswordTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: L10n.back,
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: self,
                                                                action: #selector(self.onBack))
    }
    
    @objc func onBack() {
        self.viewData.onBack?()
    }
}
