//
//  UITableView+Register.swift
//  UIKitLib
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

public extension IDP where Base: UITableView {
    /**
     Create UINib object based on cells type and register nib with cell type as identifier
     */
    func register(cells: Set<String>) {
        cells.forEach { type in
            self.register(cell:type)
        }
    }
    
    func register(cells: String...) {
        self.register(cells: Set(cells))
    }
    
    func register(cells: UITableViewCell.Type...) {
        self.register(cells: Set(cells.map { F.toString($0) }))
    }
    
    func register(cellClass: UITableViewCell.Type) {
        self.register(cell: F.toString(cellClass))
    }
    
    func register(cell: String) {
        let nib = UINib.init(nibName: cell, bundle: nil)
        self.base.register(nib, forCellReuseIdentifier: cell)
    }
    
    func register(headerFooters: [String]) {
        headerFooters.forEach { type in
            self.register(headerFooter:type)
        }
    }
    
    func register(headerFooter: String) {
        let nib = UINib.init(nibName: headerFooter, bundle: nil)
        self.base.register(nib, forHeaderFooterViewReuseIdentifier: headerFooter)
    }
    
    func register(headerFooterClass: AnyClass) {
        self.register(headerFooter: F.toString(headerFooterClass))
    }
}
