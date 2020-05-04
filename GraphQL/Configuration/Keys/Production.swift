//
//  Production.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

enum Keys {

    // MARK: - Type Properties

    static let baseURL = URL(string: "https://api.github.com/graphql")!

    static let githubTokenAPI = ProcessInfo.processInfo.environment["GithubApiKey"]!
}
