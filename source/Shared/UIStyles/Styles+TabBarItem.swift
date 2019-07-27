//
//  Styles+TabBarItem.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 3/29/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import IDPDesign
import UIKit

extension Styles {
    enum TabBarItem {}
}

extension Styles.TabBarItem {
    static func `default`() -> Style<UITabBarItem> {
        return design { tabBarItem in
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(named: Colors.darkGrayishBlue)],
                                                             for: .selected)
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(named: Colors.blueGrey).withAlphaComponent(0.5)],
                                                             for: .normal)
            return tabBarItem
        }
    }
}
