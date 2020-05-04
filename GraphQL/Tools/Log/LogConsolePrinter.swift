//
//  LogConsolePrinter.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 03/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

public class LogConsolePrinter: LogPrinter {

    // MARK: - Type Properties

    public static let shared = LogConsolePrinter()

    // MARK: - Initializers

    private init() { }

    // MARK: - LogPrinter

    public func print(_ line: String) {
        Swift.print(line)
    }
}
