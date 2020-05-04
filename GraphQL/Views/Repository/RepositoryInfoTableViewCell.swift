//
//  RepositoryInfoTableViewCell.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit

final class RepositoryInfoTableViewCell: UITableViewCell {

    // MARK: - Instance Properties

    @IBOutlet private weak var fieldLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!

    // MARK: -

    var field: String? {
        get {
            self.fieldLabel.text
        }

        set {
            self.fieldLabel.text = newValue
        }
    }

    var value: String? {
        get {
            self.valueLabel.text
        }

        set {
            self.valueLabel.text = newValue
        }
    }
}
