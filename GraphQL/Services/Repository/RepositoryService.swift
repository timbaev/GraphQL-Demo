//
//  RepositoryService.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation
import PromiseKit

protocol RepositoryService {

    // MARK: - Instance Methods

    func search(with searchText: String) -> Promise<[RepositorySearchResult]>
    func fetchRepository(with name: String, owner: String) -> Promise<Repository>
}
