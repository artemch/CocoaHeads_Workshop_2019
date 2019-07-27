//
//  Styles+TextField.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 3/4/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import IDPDesign
import AppUIKit

extension Styles {
    enum TextField {}
}

extension Styles.TextField {
    static func `default`() -> Style<IDPTextField> {
        return design { textField in
            textField.errorLineColor = UIColor(named: .grapefruit)
            textField.errorColor = UIColor(named: .grapefruit)
            textField.lineColor = UIColor(named: .lightBlueGrey)
            textField.activeLineColor = UIColor(named: .tealish)
            textField.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            return textField
        } • defaultFont() • defaultTextColor()
    }
    
    static func defaultFont<TextField: UITextField>() -> Style<TextField> {
        return design(
            font ~ UIFont.systemFont(ofSize: 17, weight: .regular)
        )
    }
    
    static func defaultTextColor<TextField: UITextField>() -> Style<TextField> {
        return design(
            textColor ~ UIColor(named: .black)
        )
    }
    
    static func attributedPlaceholder<TextField: UITextField>(placeholder: String, color: UIColor) -> Style<TextField> {
        return design(
            IDPDesign.attributedPlaceholder ~ NSAttributedString(string: placeholder,
                                                                 attributes: [NSAttributedString.Key.foregroundColor : color])
        )
    }
    
    static func goalAttributedPlaceholder<TextField: UITextField>(placeholder: String = "--") -> Style<TextField> {
        return attributedPlaceholder(placeholder:  placeholder, color: UIColor(named: .tealish))
    }
    
    static func placeholder(placeholder: String?) -> Style<UITextField> {
        return design(
            IDPDesign.placeholder() ~ placeholder
        )
    }
}
