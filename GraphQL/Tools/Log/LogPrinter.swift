//
//  LogPrinter.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 03/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

public protocol LogPrinter: AnyObject {

    // MARK: - Instance Methods

    func print(_ line: String)
}
