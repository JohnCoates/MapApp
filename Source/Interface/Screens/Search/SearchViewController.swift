//
//  SearchViewController.swift
//  6/9/21
//

import Combine
import UIKit

final class SearchViewController: ProgrammaticViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = SearchViewModel()

    // MARK: - View Lifecycle

    private var _view: SearchView = .init()

    override func loadView() {
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = .title

        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = .placeholder
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }

    // MARK: - Register Events, Bindings

    override func registerEvents() {
        viewModel.delegate = self

        _view.tableView.dataSource = viewModel
        _view.tableView.delegate = viewModel
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text ?? ""
        viewModel.search(for: searchTerm)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchController.searchBar.text ?? ""
        viewModel.search(for: searchTerm, immediate: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(for: "", immediate: true)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func selected(result: OpenCageResponseResult) {
        let viewController = newViewController() as ResultViewController
        viewController.result = result
        navigationController?.pushViewController(viewController, animated: true)
    }

    func reloadTable() {
        _view.tableView.reloadData()
    }
}

// MARK: - Localized Strings

fileprivate extension String {
    static let title = NSLocalizedString("SEARCH_TITLE",
                                         value: "Search",
                                         comment: "Title on search screen")
    static let placeholder = NSLocalizedString("SEARCH_PLACEHOLDER",
                                               value: "Search for a location",
                                               comment: "Placeholder on search screen")
}
