//
//  EmptyStateViewable.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit

protocol EmptyStateViewable {

    // MARK: - Instance Properties

    var emptyStateView: EmptyStateView { get }

    // MARK: - Instance Methods

    func showEmptyState(image: UIImage?, title: String?, message: String, action: EmptyStateAction?)
    func showEmptyState(title: String?, message: String, action: EmptyStateAction)

    func showNoDataState(title: String, message: String, action: EmptyStateAction)
    func showNoDataState(message: String, action: EmptyStateAction?)

    func showInternetDisconnectionState(okHandler: (() -> Void)?)
    func showErrorState(okHandler: (() -> Void)?)
    func showErrorState(message: String, okHandler: (() -> Void)?)

    func hideEmptyState()
}

// MARK: -

extension EmptyStateViewable where Self: UIViewController {

    // MARK: - Instance Methods

    private func initialize() {
        self.emptyStateView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(self.emptyStateView)

        NSLayoutConstraint.activate([
            self.emptyStateView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.emptyStateView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.emptyStateView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.emptyStateView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

    // MARK: -

    func showEmptyState(image: UIImage?, title: String?, message: String, action: EmptyStateAction?) {
        if self.emptyStateView.superview == nil {
            self.initialize()
        }

        self.emptyStateView.hideActivityIndicator()

        self.emptyStateView.image = image
        self.emptyStateView.title = title
        self.emptyStateView.message = message
        self.emptyStateView.action = action

        self.emptyStateView.isHidden = false
    }

    func showEmptyState(title: String?, message: String, action: EmptyStateAction) {
        self.showEmptyState(image: nil, title: title, message: message, action: action)
    }

    // MARK: -

    func showNoDataState(title: String, message: String, action: EmptyStateAction) {
        self.showEmptyState(image: nil, title: title, message: message, action: action)
    }

    func showNoDataState(message: String, action: EmptyStateAction? = nil) {
        self.showEmptyState(image: nil, title: nil, message: message, action: action)
    }

    // MARK: -

    func showInternetDisconnectionState(okHandler: (() -> Void)? = nil) {
        let emptyStateAction: EmptyStateAction?

        if let okHandler = okHandler {
            emptyStateAction = EmptyStateAction(title: "Try Again", onClicked: okHandler)
        } else {
            emptyStateAction = nil
        }

        self.showEmptyState(
            image: Images.disconnectIcon,
            title: "No Internet Connection",
            message: "Please check your Wi-Fi or mobile network connection and try again.",
            action: emptyStateAction
        )
    }

    func showErrorState(okHandler: (() -> Void)? = nil) {
        let emptyStateAction: EmptyStateAction?

        if let okHandler = okHandler {
            emptyStateAction = EmptyStateAction(title: "Try Again", onClicked: okHandler)
        } else {
            emptyStateAction = nil
        }

        self.showEmptyState(
            image: Images.somethingWrongIcon,
            title: "Something went wrong",
            message: "Please let us know what went wrong or try again later.",
            action: emptyStateAction
        )
    }

    func showErrorState(message: String, okHandler: (() -> Void)? = nil) {
       let emptyStateAction: EmptyStateAction?

        if let okHandler = okHandler {
            emptyStateAction = EmptyStateAction(title: "Try Again", onClicked: okHandler)
        } else {
            emptyStateAction = nil
        }

        self.showEmptyState(
            image: Images.somethingWrongIcon,
            title: "Something went wrong",
            message: message,
            action: emptyStateAction
        )
    }

    // MARK: -

    func hideEmptyState() {
        self.emptyStateView.isHidden = true
    }
}
