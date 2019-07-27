//
//  Bundle+AppVersion.swift
//  FoundationKit
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public extension Bundle {
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
