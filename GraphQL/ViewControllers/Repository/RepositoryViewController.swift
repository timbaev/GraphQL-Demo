//
//  RepositoryViewController.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit
import PromiseKit

final class RepositoryViewController: LoggedViewController, EmptyStateViewable {

    // MARK: - Instance Properties

    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet private weak var ownerAvatarImageView: UIImageView!
    @IBOutlet private weak var ownerLoginLabel: UILabel!

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    @IBOutlet private weak var stargazersTotalCountLabel: UILabel!
    @IBOutlet private weak var forkCountLabel: UILabel!

    @IBOutlet private weak var startButton: Button!
    @IBOutlet private weak var watchButton: Button!

    // MARK: -

    private var searchResult: RepositorySearchResult?

    private var info: [RepositoryInfo] = []

    // MARK: -

    var emptyStateView = EmptyStateView()

    // MARK: - Instance Methods

    @IBAction private func onStarButtonTouchUpInside(_ sender: Button) {
        Log.high("onStarButtonTouchUpInside()", from: self)
    }

    @IBAction private func onWatchButtonTouchUpInside(_ sender: Button) {
        Log.high("onWatchButtonTouchUpInside()", from: self)
    }

    // MARK: -

    private func configureTableView() {
        self.tableView.tableFooterView = UIView()
    }

    private func configureNavigationItemTitle() {
        self.navigationItem.largeTitleDisplayMode = .never
    }

    private func configure(repositoryInfoCell cell: RepositoryInfoTableViewCell, at indexPath: IndexPath) {
        let info = self.info[indexPath.row]

        cell.field = info.field
        cell.value = info.value
    }

    // MARK: -

    private func fetchRepository(for searchResult: RepositorySearchResult) {
        self.showLoadingState()

        firstly {
            Dependencies.repositoryService.fetchRepository(with: searchResult.name, owner: searchResult.owner.login)
        }.done { repository in
            self.apply(repository: repository)
        }.catch { error in
            self.handle(stateError: error)
        }
    }

    // MARK: -

    private func showLoadingState() {
        self.showEmptyState(image: nil, title: nil, message: "Loading...", action: nil)
        self.emptyStateView.showActivityIndicator()
    }

    private func finishLoadingState() {
        self.hideEmptyState()
    }

    // MARK: -

    private func apply(repository: Repository) {
        Log.high("apply(repository: \(repository.name))")

        if let url = URL(string: repository.owner.avatarUrl) {
            Dependencies.imageLoader.loadImage(for: url, in: self.ownerAvatarImageView)
        }

        self.ownerLoginLabel.text = repository.owner.login
        self.nameLabel.text = repository.name
        self.descriptionLabel.text = repository.description
        self.stargazersTotalCountLabel.text = "\(repository.stargazers.totalCount.kFormatted) Stars"
        self.forkCountLabel.text = "\(repository.forkCount.kFormatted) Forks"

        self.apply(isViewerHasStarred: repository.viewerHasStarred)
        self.apply(viewerSubscription: repository.viewerSubscription ?? .ignored)

        self.info = [
            RepositoryInfo(field: "Issues", value: "\(repository.issues.totalCount)"),
            RepositoryInfo(field: "Pull Requests", value: "\(repository.pullRequests.totalCount)"),
            RepositoryInfo(field: "Watchers", value: "\(repository.watchers.totalCount)"),
            RepositoryInfo(field: "License", value: repository.licenseInfo?.name)
        ]

        self.tableView.reloadData()

        self.finishLoadingState()
    }

    private func apply(isViewerHasStarred: Bool) {
        Log.high("apply(isViewerHasStarred: \(isViewerHasStarred))", from: self)

        if isViewerHasStarred {
            self.startButton.defaultTitleColor = .systemYellow
            self.startButton.highlightedTitleColor = .systemYellow
            self.startButton.setTitle("Starred", for: .normal)
        } else {
            self.startButton.defaultTitleColor = .systemBlue
            self.startButton.highlightedTitleColor = .systemBlue
            self.startButton.setTitle("Star", for: .normal)
        }
    }

    private func apply(viewerSubscription: SubscriptionState) {
        Log.high("apply(viewerSubscription: \(viewerSubscription.rawValue))", from: self)

        switch viewerSubscription {
        case .subscribed:
            self.watchButton.defaultTitleColor = .systemGreen
            self.watchButton.highlightedTitleColor = .systemGreen
            self.watchButton.setTitle("Watching", for: .normal)

        case .ignored, .unsubscribed:
            self.watchButton.defaultTitleColor = .systemBlue
            self.watchButton.highlightedTitleColor = .systemBlue
            self.watchButton.setTitle("Watch", for: .normal)

        default:
            break
        }
    }

    // MARK: -

    private func handle(stateError error: Error) {
        Log.high("handle(stateError: \(error))", from: self)

        switch error as? WebError {
        case .some(.connection), .some(.timeOut):
            self.showInternetDisconnectionState()

        case .some(let webError) where webError.detailDescription != nil:
            self.showErrorState(message: webError.detailDescription!)

        default:
            self.showErrorState()
        }
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        self.configureNavigationItemTitle()

        if let searchResult = self.searchResult {
            self.fetchRepository(for: searchResult)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.tableView.sizeHeaderToFit()
    }
}

// MARK: - UITableViewDataSource

extension RepositoryViewController: UITableViewDataSource {

    // MARK: - Instance Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.info.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .infoTableCellIdentifier, for: indexPath)

        self.configure(repositoryInfoCell: cell as! RepositoryInfoTableViewCell, at: indexPath)

        return cell
    }
}

// MARK: - RepositoryDataInput

extension RepositoryViewController: RepositoryDataInput {

    // MARK: - Instance Methods

    func apply(searchResult: RepositorySearchResult) {
        self.searchResult = searchResult
    }
}

// MARK: -

private extension String {

    // MARK: - Type Properties

    static let infoTableCellIdentifier = "InfoTableCell"
}
