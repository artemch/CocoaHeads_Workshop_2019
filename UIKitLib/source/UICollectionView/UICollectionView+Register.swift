//
//  UICollectionView+Register.swift
//  UIKitLib
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

public extension IDP where Base: UICollectionView {
    /**
     Create UINib object based on cells type and register nib with cell type as identifier
     */
    func register(cells: Set<String>) {
        cells.forEach { type in
            self.register(cell: type)
        }
    }
    
    func register(cell: String) {
        let nib = UINib(nibName: cell, bundle: nil)
        self.base.register(nib, forCellWithReuseIdentifier: cell)
    }
    
    func register(cellClass: AnyClass) {
        self.register(cell: F.toString(cellClass))
    }
    
    func register(supplementaryView: String, ofKind kind: String) {
        let nib = UINib(nibName: supplementaryView, bundle: nil)
        self.base.register(nib,
                      forSupplementaryViewOfKind: kind,
                      withReuseIdentifier: supplementaryView)
    }
    
    func register(supplementaryViewClass: UICollectionReusableView.Type, ofKind kind: String) {
        self.register(supplementaryView: "\(supplementaryViewClass)",
            ofKind: kind)
    }
}
