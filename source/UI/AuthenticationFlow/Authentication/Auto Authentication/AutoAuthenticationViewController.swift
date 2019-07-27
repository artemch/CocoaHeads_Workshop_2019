import UIKit
import Services
import ReactiveSwift
import ReactiveCocoa
import Result
import Models
import PresentationModels
import UIKitLib

class AutoAuthenticationViewController<Model: AutoAuthenticationPresentationModel>: BaseViewDataController <Model, AutoAuthenticationView> {
    
    // MARK: - Initializations and Deallocations
    
    init(presentationModel: Model) {
        super.init(presentationModel: presentationModel,
                   nibName: nil,
                   bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func loadView() {
        self.view = RootViewType(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth()
    }
    
    // MARK: - Private methods
    
    private func auth() {
        if case let .auth(action) = self.viewData {
            action()
        }
    }
    
}
