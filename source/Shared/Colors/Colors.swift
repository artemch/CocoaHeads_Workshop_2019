//
//  Colors.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 2/18/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import UIKit.UIColor

//Representation of Colors.xcassets
enum Colors: String {
    case grapefruit = "grapefruit"
    case slate = "slate"
    case light = "light"
    case tealish = "tealish"
    case white = "white"
    case black = "black"
    case lightBlueGrey = "lightBlueGrey"
    case paleGrey = "paleGrey"
    case darkGrayishBlue = "darkGrayishBlue"
    case blueGrey = "blueGrey"
    case tealishLight = "tealishLight"
}

extension UIColor {
    convenience init(named color: Colors) {
        self.init(named: color.rawValue)!
    }
}
