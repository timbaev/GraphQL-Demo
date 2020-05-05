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
            self.webClient.fetch(query: query, cachePolicy: .returnCacheDataAndFetch, resultHandler: { result in
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
            })
        })
    }

    func fetchRepository(with name: String, owner: String) -> Promise<Repository> {
        let query = FetchRepositoryQuery(name: name, owner: owner)

        return Promise(resolver: { seal in
            self.webClient.fetch(query: query, cachePolicy: .fetchIgnoringCacheData, resultHandler: { result in
                switch result {
                case .success(let graphQLResult):
                    guard let data = graphQLResult.data else {
                        return seal.reject(WebError.badResponse)
                    }

                    guard let repository = data.repository?.fragments.repositoryDetailsFields else {
                        return seal.reject(WebError.badResponse)
                    }

                    seal.fulfill(repository)

                case .failure(let error):
                    seal.reject(error)
                }
            })
        })
    }

    func addStar(to repositoryID: String) -> Promise<Repository> {
        let mutation = AddStarMutation(starrableID: repositoryID)

        return Promise(resolver: { seal in
            self.webClient.perform(mutation: mutation, resultHandler: { result in
                switch result {
                case .success(let graphQLResult):
                    guard let data = graphQLResult.data else {
                        return seal.reject(WebError.badResponse)
                    }

                    guard let repository = data.addStar?.starrable?.asRepository?.fragments.repositoryDetailsFields else {
                        return seal.reject(WebError.badResponse)
                    }

                    seal.fulfill(repository)

                case .failure(let error):
                    seal.reject(error)
                }
            })
        })
    }

    func removeStar(from repositoryID: String) -> Promise<Repository> {
        let mutation = RemoveStarMutation(starrableID: repositoryID)

        return Promise(resolver: { seal in
            self.webClient.perform(mutation: mutation, resultHandler: { result in
                switch result {
                case .success(let graphQLResult):
                    guard let data = graphQLResult.data else {
                        return seal.reject(WebError.badResponse)
                    }

                    guard let repository = data.removeStar?.starrable?.asRepository?.fragments.repositoryDetailsFields else {
                        return seal.reject(WebError.badResponse)
                    }

                    seal.fulfill(repository)

                case .failure(let error):
                    seal.reject(error)
                }
            })
        })
    }
}
