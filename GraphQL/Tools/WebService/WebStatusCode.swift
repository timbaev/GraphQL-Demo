//
//  WebStatusCode.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

public struct WebStatusCode: WebErrorBase {

    // MARK: - Instance Properties

    public var rawValue: Int

    // MARK: - WebErrorBase

    public var logDescription: String {
        return "WebStatusCode: \(self.rawValue)"
    }
}
