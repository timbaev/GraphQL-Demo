//
//  RoundView.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 03/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit

class RoundView: UIView {

    // MARK: - Initializers

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)

        self.layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.layer.masksToBounds = true
    }

    // MARK: - UIView

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = min(self.frame.width, self.frame.height) * 0.5
    }
}
