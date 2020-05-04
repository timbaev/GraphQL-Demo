//
//  UITableView+Extensions.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit

extension UITableView {

    // MARK: - Instance Methods

    func sizeHeaderToFit() {
        guard let headerView = self.tableHeaderView else {
            return
        }

        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
        }

        self.tableHeaderView = headerView
    }

    func sizeFooterToFit() {
        guard let footerView = self.tableFooterView else {
            return
        }

        let size = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
        }

        self.tableFooterView = footerView
    }
}
