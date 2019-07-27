

import UIKit

public class KTGLabel: UILabel {

    public var inset: UIEdgeInsets = UIEdgeInsets() {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    // MARK: - Override methods
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        rect = rect.inset(by: self.inset.invert)
        return rect
    }
}

fileprivate extension UIEdgeInsets {
    var invert: UIEdgeInsets {
        return UIEdgeInsets(top: -self.top, left: -self.left, bottom: -self.bottom, right: -self.right)
    }
}
