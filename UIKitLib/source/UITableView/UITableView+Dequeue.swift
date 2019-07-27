//
//  UITableView+Dequeue.swift
//  UIKitLib
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

public extension IDP where Base: UITableView {
    func dequeueReusableCell(withCellClass cellClass: AnyClass) -> UITableViewCell? {
        return self.base.dequeueReusableCell(withIdentifier: F.toString(cellClass))
    }
    
    func dequeueReusableCell(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
        return self.base.dequeueReusableCell(withIdentifier: F.toString(cellClass), for: indexPath)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.base.dequeueReusableCell(withIdentifier: F.toString(cellClass), for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(with: T.self, for: indexPath)
    }
}
