import UIKit

extension FUI {
    static func createEmailFieldRightView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "text_field_icon_email"))
        imageView.sizeToFit()
        return imageView
    }
}
