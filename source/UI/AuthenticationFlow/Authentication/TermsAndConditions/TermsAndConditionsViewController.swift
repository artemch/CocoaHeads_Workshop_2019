import UIKit
import PresentationModels

class TermsAndConditionsViewController: BaseViewDataController<TermsAndConditionsPresentationModel, TermsAndConditionsView> {

    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
    }
    
    // MARK: - Interface Handling
    
    @IBAction func onAgree(_ sender: UIButton) {
        self.viewData.onAgree?()
    }

    // MARK: - Private methods
    
    private func setupNavBar() {
        self.title = L10n.termsAndConditionsTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: L10n.back,
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: self,
                                                                action: #selector(onBack))
    }
    
    @objc private func onBack() {
        self.viewData.onBack?()
    }
}
