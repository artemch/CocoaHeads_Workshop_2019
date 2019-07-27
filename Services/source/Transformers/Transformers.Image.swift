//
//  Transformers.Image.swift
//  Services
//
//  Created by Artem Chabannyi on 4/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import SharedLocalization

extension Transformers {
    static func transform(value: UIImage, compressionQuality: Float = 0.8) -> Result<Data, ServiceError> {
        if let date = Transformers.transform(value: value, compressionQuality: compressionQuality) {
            return .success(date)
        } else {
            return .failure(ServiceError.error(reason: L10n.Errors.failedTransformImageToData))
        }
    }
}

extension Transformers {
    static func transform(value: UIImage, compressionQuality: Float = 0.8) -> Data? {
        return value.jpegData(compressionQuality: CGFloat(compressionQuality))
    }
}
