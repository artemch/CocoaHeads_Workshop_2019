

import UIKit

extension UIView {
    
    public func rounded(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
