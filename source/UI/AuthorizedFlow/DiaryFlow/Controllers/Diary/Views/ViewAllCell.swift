//
//  ViewAllCell.swift
//  Ketogenic
//
//  Created by Oleg Podluzhnyi on 4/16/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import UIKit

public class ViewAll: UIView {
    
    public var infoText: String {
        get { return self.infoLabel.text ?? "" }
        set { self.infoLabel.text = newValue }
    }
    
    private let infoLabel = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.baseInit()
    }
    
    private func baseInit() {
        self.backgroundColor = UIColor(named: .paleGrey)
        self.setupInfoLabel()
    }
    
    private func setupInfoLabel() {
        let infoLabel = self.infoLabel
        self.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
            ])
        
        infoLabel.textAlignment = .left
        infoLabel.numberOfLines = 2
        
        infoLabel ?|> Styles.Label.font(fontSize: 13, weight: .regular)
        infoLabel ?|> Styles.Label.textColor(color: .blueGrey)
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.layoutFittingExpandedSize.width, height: 50)
    }
}
