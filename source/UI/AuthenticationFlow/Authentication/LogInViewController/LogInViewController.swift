import UIKit
import ReactiveSwift
import ReactiveCocoa
import FoundationKit
import Validators
import Result
import Services
import Models
import PresentationModels
import UIKitLib

class LogInViewController<Model: LoginWithEmailPresentationModel>: BaseViewDataController<Model, LogInView>, UITextFieldDelegate, KeyboardFocusViewController {
    
    // MARK: - Private properties
    
    private var oldViewData: ViewData?
    
    // MARK: - Initializations and Deallocations
    
    init(presentationModel: Model) {
        super.init(presentationModel: presentationModel,
                   nibName: nibNameForViewController(type: LogInViewController.self),
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
    
    @IBAction func onLogIn(_ sender: UIButton) {
        self.viewData.onLogin?()
    }
    
    @IBAction func onResetPassword(_ sender: UIButton) {
        self.viewData.resetPassword?()
    }
    
    @IBAction func onDoNotHaveAccount(_ sender: UIButton) {
        self.viewData.doNotHaveAccount?()
    }
    
    @objc private func onShowPassword(_ sender: UIButton) {
        self.viewData.onShowPassword?()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        let rootView = self.rootView
        let viewData = self.viewData
        
        switch textField {
        case rootView?.loginTextField:
            viewData.onUpdateLogin?(textField.text ?? "")
        case rootView?.passwordTextField:
            viewData.onUpdatePassword?(textField.text ?? "")
        default:
            break
        }
    }
    
    // MARK: - Private methods
    
    fileprivate func setupNavBar() {
        self.title = L10n.signinTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: L10n.back,
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: self,
                                                                action: #selector(onBack))
    }
    
    @objc private func onBack() {
        self.viewData.back?()
    }
    
    private func bindOnView() {
        self.rootView?.showPasswordButton?.addTarget(self, action: #selector(onShowPassword(_:)),
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
