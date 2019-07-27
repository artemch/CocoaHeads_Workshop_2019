//
//  UIViewController+ToNibName.swift
//  Alamofire
//
//  Created by Artem Chabannyi on 3/22/19.
//

import Foundation
import UIKit

//Remove module name. Remove generic from controller name.
public func nibNameForViewController(type: UIViewController.Type) -> String {
    let nibName = "\(type)".components(separatedBy: ".").first.map { $0.prefix { $0 != "<" } }.map { String($0) }
    return nibName ?? F.toString(type)
}
