//
//  URLPathBuilder.swift
//  BackendServices
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

struct URLPathBuilder {
    
    let host: String
    
    let version: String
    
    let components: [String]
    
    func append(component: String) -> URLPathBuilder {
        return URLPathBuilder(host: self.host,
                              version: self.version,
                              components: self.components + [component])
    }
    
    func append(components: [String]) -> URLPathBuilder {
        if !components.isEmpty {
            return components.reduce(self) { (result, component) in result.append(component: component) }
        } else {
            return self
        }
    }
    
    func build() -> String {
        let pathComponents = [self.host] + [self.version] + self.components
        return pathComponents.joined(separator: "/")
    }
}
