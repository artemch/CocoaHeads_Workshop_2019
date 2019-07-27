import UIKit

extension FUI {
    static func createFullNameFieldRightButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "text_field_clear_button"), for: .normal)
        button.tintColor = .clear
        button.sizeToFit()
        return button
    }
}
