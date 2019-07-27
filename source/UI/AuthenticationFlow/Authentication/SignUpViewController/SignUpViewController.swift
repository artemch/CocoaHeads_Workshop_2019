import UIKit
import ReactiveSwift
import ReactiveCocoa
import PresentationModels
import UIKitLib

class SignUpViewController<Model: SignUpWithEmailPresentationModel>: BaseViewDataController<Model, SignUpView>, UITextFieldDelegate, KeyboardFocusViewController {
    
    // MARK: - Private properties
    
    private var oldViewData: ViewData?
    
    // MARK: - Initializations and Deallocations
    
    init(presentationModel: Model) {
        super.init(presentationModel: presentationModel,
                   nibName: nibNameForViewController(type: SignUpViewController.self),
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
        self.bindOnView()
    }
    
    // MARK: - Override methods
    
    override func render(viewData: ViewData) {
        super.render(viewData: viewData)
        self.renderAlert(viewData: viewData)
        self.oldViewData = viewData
    }
    
    // MARK: - Interface Handling
    
    @IBAction func onSignUp(_ sender: UIButton) {
        self.viewData.onSignUp?()
    }
    
    @IBAction func onHaveAccount(_ sender: UIButton) {
        self.viewData.onHaveAccount?()
    }
    
    @IBAction func onAgree(_ sender: UIButton) {
        self.viewData.onAgree?()
    }
    
    @IBAction func onTermsAndConditions() {
        self.viewData.onTermsAndConditions?()
    }
    
    @objc private func onShowPassword(_ sender: UIButton) {
        self.viewData.onShowPassword?()
    }
    
    @objc private func onBack() {
        self.viewData.back?()
    }
    
    @objc private func onClearFullName() {
        self.viewData.onUpdateFullName?(nil)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text
        let rootView = self.rootView
        let viewData = self.viewData
        
        switch textField {
        case rootView?.loginTextField:
            viewData.onUpdateLogin?(text ?? "")
        case rootView?.passwordTextField:
            viewData.onUpdatePassword?(text ?? "")
        case rootView?.fullNameTextField:
            viewData.onUpdateFullName?(text)
        default:
            break
        }
    }
    
    // MARK: - Private methods
    
    fileprivate func setupNavBar() {
        self.title = L10n.signupTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: L10n.back,
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: self,
                                                                action: #selector(onBack))
    }
    
    private func bindOnView() {
        self.rootView?.showPasswordButton?.addTarget(self, action: #selector(onShowPassword(_:)),
                                                     for: .touchUpInside)
        self.rootView?.clearFullNameButton?.addTarget(self, action: #selector(onClearFullName),
                                                      for: .touchUpInside)
    }
    
    private func renderAlert(viewData: ViewData) {
        if let alertError = viewData.alertError, self.oldViewData?.alertError != viewData.alertError {
            self.showErrorAlert(error: alertError)
        }
    }
    
    private func showErrorAlert(error: AlertError) {
        let alertController = UIAlertController(title: error.title,
                                                message: error.message,
                                                preferredStyle: .alert)
        let actions = error
            .actions
            .map { action in UIAlertAction(title: action.title, style: action.style, handler: { _ in action.action() }) }
        actions.forEach { alertController.addAction($0 ) }
        self.present(alertController, animated: true, completion: nil)
    }
}
