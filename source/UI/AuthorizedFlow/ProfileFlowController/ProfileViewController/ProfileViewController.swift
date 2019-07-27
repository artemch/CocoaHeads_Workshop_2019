import UIKit
import PresentationModels
import UIKitLib

class ProfileViewController<Model: ProfilePresentationModel>: BaseViewDataController<Model, ProfileView>, KeyboardToolbarAppearance, KeyboardFocusViewController {
    
    // MARK: - Initializations and Deallocations
    
    init(presentationModel: Model) {
        super.init(presentationModel: presentationModel,
                   nibName: nibNameForViewController(type: ProfileViewController.self),
                   bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enabledKeyboardToolbar()
        self.enableKeyboardFocus()
    }
    
    // MARK: - Interface Handling
    
    @IBAction func onLogOut(_ sender: UIButton) {
        self.viewData.onLogOut?()
    }
}
