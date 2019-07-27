//
//  Transformers.Encode.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 4/16/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

extension Transformers {
    enum Encoder {}
}

extension Transformers.Encoder {
    static func encode(value: Date, dateFormat: String = "YYYY-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: value)
    }
}
