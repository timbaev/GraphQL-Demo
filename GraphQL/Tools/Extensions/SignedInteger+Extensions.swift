//
//  SignedInteger+Extensions.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

extension SignedInteger {

    // MARK: - Instance Properties

    var kFormatted: String {
        String(format: self >= 1_000 ? "%dK" : "%d", (self >= 1_000 ? self / 1_000 : self) as! CVarArg)
    }
}
