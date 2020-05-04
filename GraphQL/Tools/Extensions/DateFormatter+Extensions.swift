//
//  DateFormatter+Extensions.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 03/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import Foundation

extension DateFormatter {

    // MARK: - Initializers

    public convenience init(dateFormat: String) {
        self.init()

        self.dateFormat = dateFormat
    }
}
