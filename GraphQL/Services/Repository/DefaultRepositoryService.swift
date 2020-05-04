//
//  DefaultRepositoryService.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation
import Apollo
import PromiseKit

struct DefaultRepositoryService: RepositoryService {

    // MARK: - Instance Properties

    let webClient: ApolloClientProtocol

    // MARK: - RepositoryService

    func search(with searchText: String) -> Promise<[RepositorySearchResult]> {
        let query = SearchRepositoriesQuery(searchText: searchText)

        return Promise(resolver: { seal in
            self.webClient.fetch(
                query: query,
                cachePolicy: .returnCacheDataAndFetch,
                resultHandler: { result in
                    switch result {
                    case .success(let graphQLResult):
                        guard let data = graphQLResult.data, let nodes = data.search.nodes else {
                            return seal.reject(WebError.badResponse)
                        }

                        let searchResults: [RepositorySearchResult] = nodes.compactMap { node in
                            guard let asRepository = node?.asRepository else {
                                return nil
                            }

                            return asRepository.fragments.repositorySearchResult
                        }

                        return seal.fulfill(searchResults)

                    case .failure(let error):
                        seal.reject(error)
                    }
                }
            )
        })
    }
}
