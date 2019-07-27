import UIKit
import PresentationModels
import SnapKit

class AutoAuthenticationView: UIView, ViewDataRenderableView {
    
    typealias ViewData = AutoAuthenticationViewData
    
    private let activityView = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: - Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    // MARK: - ViewDataRenderableView
    
    func render(viewData: ViewData) {
        switch viewData {
        case .checking, .auth(_):
            self.activityView.startAnimating()
        case .authorized, .notAuthorized:
            self.activityView.stopAnimating()
        }
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        let activityView = self.activityView
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        activityView.color = UIColor(named: .black)
        self.addSubview(self.activityView)
        self.backgroundColor = UIColor(named: .white)
        activityView.snp.makeConstraints {
            $0.center.equalTo(self)
        }
    }
}
