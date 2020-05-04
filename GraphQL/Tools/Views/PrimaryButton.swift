//
//  PrimaryButton.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit

final class PrimaryButton: Button {

    // MARK: - Initializers

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        self.initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.initialize()
    }

    // MARK: - Instance Methods

    private func initialize() {
        self.defaultTitleColor = Colors.whiteText
        self.defaultBackgroundColor = Colors.primary

        self.disabledTitleColor = Colors.grayText
        self.disabledBackgroundColor = Colors.lightGrayBackground

        self.titleLabel?.font = Fonts.bold(ofSize: 16)

        self.cornerRadius = 8
    }
}
