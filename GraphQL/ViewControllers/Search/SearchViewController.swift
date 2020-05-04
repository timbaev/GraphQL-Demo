//
//  SearchViewController.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 03/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit
import PromiseKit

class SearchViewController: LoggedViewController, EmptyStateViewable {

    // MARK: - Nested Types

    private enum Segues {

        // MARK: - Type Properties

        static let showRepository = "ShowRepository"
    }

    // MARK: - Instance Properties

    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: -

    private let throttler = Throttler(minimumDelay: 1.5)
    private var searchResults: [RepositorySearchResult] = []

    // MARK: -

    var emptyStateView = EmptyStateView()

    // MARK: - Instance Methods

    private func configureSearchBar() {
        let search = UISearchController(searchResultsController: nil)

        search.searchResultsUpdater = self
        search.searchBar.delegate = self

        self.navigationItem.searchController = search
    }

    private func configure(repositoryTableCell cell: RepositoryTableViewCell, at indexPath: IndexPath) {
        let searchResult = self.searchResults[indexPath.row]

        cell.ownerLogin = searchResult.owner.login
        cell.name = searchResult.name
        cell.repoDescription = searchResult.description

        if let rawColor = searchResult.primaryLanguage?.color {
            cell.primaryLanguageColor = UIColor(rgbHexString: rawColor)
        }

        cell.primaryLanguageName = searchResult.primaryLanguage?.name
        cell.stargazersTotalCount = searchResult.stargazers.totalCount.kFormatted
    }

    // MARK: -

    private func searchRepositories(with searchText: String) {
        self.showLoadingState()

        firstly {
            Dependencies.repositoryService.search(with: searchText)
        }.ensure {
            self.finishLoadingState()
        }.done { searchResults in
            self.apply(searchResults: searchResults)
        }.catch { error in
            self.handle(stateError: error)
        }
    }

    // MARK: -

    private func showLoadingState() {
        self.tableView.isHidden = true

        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }

    private func finishLoadingState() {
        self.tableView.isHidden = false

        self.activityIndicator.stopAnimating()
    }

    // MARK: -

    private func apply(searchResults: [RepositorySearchResult]) {
        Log.high("apply(searchResults: \(searchResults.count))", from: self)

        self.searchResults = searchResults

        if searchResults.isEmpty {
            self.showNoDataState(message: "Repositories not found")
        } else {
            self.hideEmptyState()
        }

        self.tableView.reloadData()
    }

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

        self.configureSearchBar()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch segue.identifier {
        case Segues.showRepository:
            guard let dataInput = segue.destination as? RepositoryDataInput else {
                fatalError("Unexpected data input")
            }

            guard let searchResult = sender as? RepositorySearchResult else {
                fatalError("Unexpected sender type")
            }

            dataInput.apply(searchResult: searchResult)

        default:
            break
        }
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {

    // MARK: - Instance Methods

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.count > .minSearchTextCount else {
            return
        }

        self.throttler.throttle { [unowned self] in
            self.searchRepositories(with: searchText)
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

    // MARK: - Instance Methods

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController?.isActive = false
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {

    // MARK: - Instance Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .repositoryTableCellIdentifier, for: indexPath)

        self.configure(repositoryTableCell: cell as! RepositoryTableViewCell, at: indexPath)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {

    // MARK: - Instance Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        self.performSegue(withIdentifier: Segues.showRepository, sender: self.searchResults[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? RepositoryTableViewCell else {
            return
        }

        if let url = URL(string: self.searchResults[indexPath.row].owner.avatarUrl) {
            Dependencies.imageLoader.loadImage(for: url, in: cell.onwerAvatarImageView)
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? RepositoryTableViewCell else {
            return
        }

        Dependencies.imageLoader.cancelLoading(in: cell.onwerAvatarImageView)
    }
}

// MARK: -

private extension Int {

    // MARK: - Type Properties

    static let minSearchTextCount = 3
}

// MARK: -

private extension String {

    // MARK: - Type Properties

    static let repositoryTableCellIdentifier = "RepositoryTableCell"
}
