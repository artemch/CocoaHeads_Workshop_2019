//
//  DSL.swift
//  Workshop_2019
//
//  Created by Artem Chabannyi on 3/4/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import IDPDesign

/**
 Applies style to optional object.
 
 - returns: Optional object with style applied.
 */
@discardableResult
public func ?|> <Object>(view: Object?, style: Style<Object>) -> Object? {
    return view.map { style.apply($0) }
}
