//
//  WebErrorBase.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

public protocol WebErrorBase {

    // MARK: - Instance Properties

    var logDescription: String { get }
}

// MARK: - URLError

extension URLError: WebErrorBase {

    // MARK: - Instance Properties

    public var logDescription: String {
        return "URLError: \(self.code.rawValue)"
    }
}
