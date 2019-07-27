//
//  Styles+Button.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 3/4/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import IDPDesign

extension Styles {
    enum Button {}
}

extension Styles.Button {
    
    enum ButtonStyleType {
        case green
        case light
        
        static var `default`: ButtonStyleType {
            return .green
        }
    }
    
    static func `default`(style: ButtonStyleType = .default) -> Style<UIButton> {
        return design(
            style.config(),
            layer ~ design(
                cornerRadius ~ 4
            ),
            titleLabel ~ design(
                font ~ UIFont.systemFont(ofSize: 14, weight: .regular)
            )
        )
    }
}

extension Styles.Button {
    static func title(title: String?, for state: UIControl.State) -> Style<UIButton> {
        return design(
            IDPDesign.title(for: state) ~ title
        )
    }
}

extension Styles.Button {
    static func forgotPassword() -> Style<UIButton> {
        return design(
            backgroundColor ~ .clear,
            titleColor(for: .normal) ~ UIColor(named: .tealish),
            titleColor(for: .selected) ~ UIColor(named: .tealish),
            titleColor(for: .highlighted) ~ UIColor(named: .tealish),
            titleLabel ~ design(
                font ~ UIFont.systemFont(ofSize: 13, weight: .regular)
            )
        )
    }
    
    static func calendar() -> Style<UIButton> {
        let calendarIcon = UIImage(named: "calendar")
        
        return design(
            image(for: .normal) ~ calendarIcon,
            image(for: .selected) ~ calendarIcon,
            image(for: .highlighted) ~ calendarIcon,
            backgroundColor ~ UIColor(named: .light)
        )
    }
    
    static func add(icon: UIImage?, backgroundColor: UIColor) -> Style<UIButton> {
        return design(
            image(for: .normal) ~ icon,
            image(for: .selected) ~ icon,
            image(for: .highlighted) ~ icon,
            contentHorizontalAlignment ~ .left,
            contentEdgeInsets ~ UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 0),
            IDPDesign.backgroundColor ~ backgroundColor
        )
    }
}

fileprivate extension Styles.Button.ButtonStyleType {
    func config() -> Style<UIButton> {
        return design({ (button: UIButton) -> UIButton in
            switch self {
            case .light:
                button.backgroundColor = UIColor(named: .light)
                let titleColor = UIColor(named: .black)
                button.setTitleColor(titleColor, for: .normal)
                button.setTitleColor(titleColor, for: .selected)
                button.setTitleColor(titleColor, for: .highlighted)
                button.setTitleColor(titleColor, for: .disabled)
            case .green:
                button.backgroundColor =  UIColor(named: .tealish)
                let titleColor = UIColor(named: .white)
                button.setTitleColor(titleColor, for: .normal)
                button.setTitleColor(titleColor, for: .selected)
                button.setTitleColor(titleColor, for: .highlighted)
                button.setTitleColor(titleColor, for: .disabled)
            }
            return button
        })
    }
}
