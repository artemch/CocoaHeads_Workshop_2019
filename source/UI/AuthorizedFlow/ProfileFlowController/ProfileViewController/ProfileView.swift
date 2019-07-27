import UIKit
import PresentationModels
import AppUIKit

class ProfileView: UIView, ViewDataRenderableView {
    
    typealias ViewData = ProfileViewData
    
    // MARK: - IBOutlets
    
    @IBOutlet var signOutButton: UIButton?
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configButtons()
    }

    // MARK: - ViewDataRenderableView
    
    func render(viewData: ViewData) {
        
    }
    
    // MARK: - Private methods
    
    private func configButtons() {
        self.signOutButton
            ?|> Styles.Button.default(style: .green)
            ?|> Styles.Button.title(title: L10n.signOut, for: .normal)
    }
}
