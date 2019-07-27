//
//  Reactive.swift
//  AlamofireReactive
//
//  Created by Artem Chabannyi on 2/11/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public protocol IDPReactiveExtensionsProvider: class {}

public extension IDPReactiveExtensionsProvider {
    /// A proxy which hosts extensions for `self`.
    var reactive: IDPReactive<Self> {
        get {
            return IDPReactive(self)
        }
        set {
            
        }
    }
    
    /// A proxy which hosts static extensions for the type of `self`.
    static var reactive: IDPReactive<Self>.Type {
        return IDPReactive<Self>.self
    }
}

/// A proxy which hosts extensions of `Base`.
public struct IDPReactive<Base> {
    /// The `Base` instance the extensions would be invoked with.
    public let base: Base
    
    public static var base: Base.Type {
        return Base.self
    }
    
    /// Construct a proxy
    ///
    /// - parameters:
    ///   - base: The object to be proxied.
    fileprivate init(_ base: Base) {
        self.base = base
    }
}
