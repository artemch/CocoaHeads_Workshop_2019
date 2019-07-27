//
//  Styles+UILabel.swift
//  AppUIKit
//
//  Created by Artem Chabannyi on 3/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import IDPDesign
import AppUIKit

extension Styles {
    enum Label {}
}

extension Styles.Label {
    
    static func bold(fontSize: Float) -> Style<UILabel> {
        return font(fontSize: fontSize, weight: .bold)
    }
    
    static func semibold(fontSize: Float) -> Style<UILabel> {
        return font(fontSize: fontSize, weight: .semibold)
    }
    
    static func medium(fontSize: Float) -> Style<UILabel> {
        return font(fontSize: fontSize, weight: .medium)
    }
    
    static func regular(fontSize: Float) -> Style<UILabel> {
        return font(fontSize: fontSize, weight: .regular)
    }
    
    static func light(fontSize: Float) -> Style<UILabel> {
        return font(fontSize: fontSize, weight: .light)
    }
    
    static func darkGray(fontSize: Float) -> Style<UILabel> {
        return design(
            regular(fontSize: fontSize),
            textColor(color: .darkGrayishBlue)
        )
    }
    
    static func font(fontSize: Float, weight: UIFont.Weight) -> Style<UILabel> {
        return design(
            IDPDesign.font ~ UIFont.systemFont(ofSize: CGFloat(fontSize), weight: weight)
        )
    }
    
    static func textColor(color: UIColor) -> Style<UILabel> {
        return design(
            IDPDesign.textColor ~ color
        )
    }
    
    static func textColor(color: Colors) -> Style<UILabel> {
        return design(
            IDPDesign.textColor ~ UIColor(named: color)
        )
    }
    
    static func backgroundColor(color: Colors) -> Style<UILabel> {
        return design(
            IDPDesign.backgroundColor() ~ UIColor(named: color)
        )
    }
    
    static func text(text: String?) -> Style<UILabel> {
        return design(
            IDPDesign.text() ~ text
        )
    }
}

extension Styles.Label {
    static func info() -> Style<UILabel> {
        return design(
            regular(fontSize: 14),
            textColor(color: .darkGrayishBlue)
        )
    }
}
