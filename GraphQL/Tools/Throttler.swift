//
//  Throttler.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 03/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

class Throttler {

    // MARK: - Instance Properties

    private var workItem = DispatchWorkItem(block: { })
    private var previousRun = Date.distantPast

    private let queue: DispatchQueue
    private let minimumDelay: TimeInterval

    // MARK: - Initializers

    init(minimumDelay: TimeInterval, queue: DispatchQueue = .main) {
        self.minimumDelay = minimumDelay
        self.queue = queue
    }

    // MARK: - Instance Methods

    func throttle(_ block: @escaping () -> Void) {
        self.workItem.cancel()

        self.workItem = DispatchWorkItem(block: { [weak self] in
            self?.previousRun = Date()

            block()
        })

        let delay = self.previousRun.timeIntervalSinceNow > self.minimumDelay ? 0 : self.minimumDelay

        self.queue.asyncAfter(deadline: .now() + delay, execute: self.workItem)
    }
}
