//
//  Dependencies.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation
import Apollo

enum Dependencies {

    // MARK: - Type Properties

    static let webClient: ApolloClientProtocol = {
        let configuration = URLSessionConfiguration.default

        configuration.httpAdditionalHeaders = ["Authorization": "bearer \(Keys.githubTokenAPI)"]

        let urlSessionClient = URLSessionClient(sessionConfiguration: configuration)
        let networkTransport = HTTPNetworkTransport(url: Keys.baseURL, client: urlSessionClient)

        return ApolloClient(networkTransport: networkTransport)
    }()

    // MARK: -

    static let repositoryService: RepositoryService = DefaultRepositoryService(webClient: webClient)

    // MARK: -

    static let imageLoader: ImageLoader = DefaultImageLoader()
}
