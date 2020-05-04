//
//  ApolloClientProtocol+Extensions.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation
import Apollo

extension ApolloClientProtocol {

    // MARK: - Instance Methods

    /// Fetches a query from the server or from the local cache, depending on the current contents of the cache and the specified cache policy.
    ///
    /// - Parameters:
    ///   - query: The query to fetch.
    ///   - cachePolicy: A cache policy that specifies when results should be fetched from the server and when data should be loaded from the local cache.
    ///   - context: [optional] A context to use for the cache to work with results. Should default to nil.
    ///   - queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
    ///   - resultHandler: [optional] A closure that is called when query results are available or when an error occurs.
    /// - Returns: An object that can be used to cancel an in progress fetch.
    @discardableResult
    func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
        context: UnsafeMutableRawPointer? = nil,
        queue: DispatchQueue = .main,
        resultHandler: GraphQLResultHandler<Query.Data>? = nil
    ) -> Cancellable {
        self.fetch(query: query, cachePolicy: cachePolicy, context: context, queue: queue, resultHandler: resultHandler)
    }
}
