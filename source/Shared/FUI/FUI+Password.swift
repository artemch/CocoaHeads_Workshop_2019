import UIKit

extension FUI {
    static func createShowPasswordButton() -> UIButton {
        let showPasswordButton = UIButton()
        showPasswordButton.setImage(UIImage(named: "text_field_icon_password"), for: .normal)
        showPasswordButton.setImage(UIImage(named: "text_field_icon_password_off"), for: .selected)
        showPasswordButton.tintColor = .clear
        showPasswordButton.sizeToFit()
        return showPasswordButton
    }
}
