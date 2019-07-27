//
//  UIImage+Color.swift
//  Alamofire
//
//  Created by Artem Chabannyi on 2/27/19.
//

import Foundation

extension UIImage {
    @available(iOS 10.0, *)
    convenience init?(color: UIColor) {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
        let image = renderer.image { (context) in
            UIColor.darkGray.setStroke()
            context.stroke(renderer.format.bounds)
            color.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage)
        } else {
            return nil
        }
    }
}
