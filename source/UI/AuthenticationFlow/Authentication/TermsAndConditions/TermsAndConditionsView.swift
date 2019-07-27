import UIKit
import PresentationModels
import IDPDesign

class TermsAndConditionsView: UIView, ViewDataRenderableView {
    
    typealias ViewData = TermsAndConditionsPresentationModel.ViewData
    
    @IBOutlet var agreeButton: UIButton?
    
    // MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.agreeButton?.setTitle(L10n.agreeAndContinue, for: .normal)
        self.agreeButton ?|> Styles.Button.default()
    }
    
    // MARK: - ViewDataRenderableView
    
    func render(viewData: ViewData) {
        self.agreeButton?.isHidden = viewData.isAgree
    }
}
