//
//  RepositoryDataInput.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

protocol RepositoryDataInput {

    // MARK: - Instance Methods

    func apply(searchResult: RepositorySearchResult)
}
