//
//  ErrorMessageViewable.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 05/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit

protocol ErrorMessageViewable {

    // MARK: - Instance Properties

    var presenterController: UIViewController { get }

    // MARK: - Instance Methods

    func showMessage(withTitle title: String?, message: String?, okHandler: (() -> Void)?)
    func showMessage(withError error: Error, okHandler: (() -> Void)?)
}

// MARK: -

extension ErrorMessageViewable where Self: UIViewController {

    // MARK: - Instance Properties

    var presenterController: UIViewController {
        return self
    }

    // MARK: - Instance Methods

    func showMessage(withTitle title: String?, message: String?, okHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            okHandler?()
        }))

        self.present(alertController, animated: true)
    }

    func showMessage(withTitle title: String?, message: String?) {
        self.showMessage(withTitle: title, message: message, okHandler: nil)
    }

    func showMessage(withError error: Error, okHandler: (() -> Void)?) {
        switch error as? WebError {
        case .some(.connection), .some(.timeOut):
            self.showMessage(withTitle: "No Internet Connection",
                             message: "Check your wi-fi or mobile data connection.",
                             okHandler: okHandler)

        default:
            self.showMessage(withTitle: "Something went wrong",
                             message: "Please let us know what went wrong or try again later.",
                             okHandler: okHandler)
        }
    }

    func showMessage(withError error: Error) {
        self.showMessage(withError: error, okHandler: nil)
    }
}
