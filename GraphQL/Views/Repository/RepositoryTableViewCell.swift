//
//  RepositoryTableViewCell.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    // MARK: - Instance Properties

    @IBOutlet private(set) weak var onwerAvatarImageView: UIImageView!
    @IBOutlet private weak var onwerLoginLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var primaryLanguageView: UIView!
    @IBOutlet private weak var primaryLanguageNameLabel: UILabel!
    @IBOutlet private weak var stargazersTotalCountLabel: UILabel!

    // MARK: -

    var ownerLogin: String? {
        get {
            self.onwerLoginLabel.text
        }

        set {
            self.onwerLoginLabel.text = newValue
        }
    }

    var name: String? {
        get {
            self.nameLabel.text
        }

        set {
            self.nameLabel.text = newValue
        }
    }

    var repoDescription: String? {
        get {
            self.descriptionLabel.text
        }

        set {
            self.descriptionLabel.text = newValue
        }
    }

    var primaryLanguageColor: UIColor? {
        get {
            self.primaryLanguageView.backgroundColor
        }

        set {
            self.primaryLanguageView.backgroundColor = newValue
        }
    }

    var primaryLanguageName: String? {
        get {
            self.primaryLanguageNameLabel.text
        }

        set {
            self.primaryLanguageNameLabel.text = newValue
        }
    }

    var stargazersTotalCount: String? {
        get {
            self.stargazersTotalCountLabel.text
        }

        set {
            self.stargazersTotalCountLabel.text = newValue
        }
    }
}
