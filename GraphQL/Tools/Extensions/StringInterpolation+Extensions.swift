//
//  StringInterpolation+Extensions.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

extension String.StringInterpolation {

    // MARK: - Instance Methods

    mutating func appendInterpolation<T>(maybe: T?) {
        if let value = maybe {
            self.appendInterpolation(value)
        } else {
            self.appendLiteral("nil")
        }
    }
}
