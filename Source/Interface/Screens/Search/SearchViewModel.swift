//
//  SearchViewModel.swift
//  6/9/21
//

import Foundation
import Combine
import UIKit

final class SearchViewModel: NSObject {
    weak var delegate: SearchViewModelDelegate?

    private var subscriptions = [AnyCancellable]()
    private var currentSearch: AnyCancellable?
    private var currentSearchTerm: String?

    private var results = [OpenCageResponseResult]() {
        didSet {
            delegate?.reloadTable()
        }
    }

    func search(for searchTerm: String, immediate: Bool = false) {
        let passthrough = PassthroughSubject<String, Never>()
        var publisher: AnyPublisher<String, Never> = passthrough.eraseToAnyPublisher()

        if !immediate && searchTerm.isEmpty == false {
            publisher = publisher.delay(for: 1, scheduler: DispatchQueue.main).eraseToAnyPublisher()
        }

        currentSearch = publisher.sink { [weak self] searchTerm in
            self?.performSearch(searchTerm: searchTerm)
        }

        passthrough.send(searchTerm)
    }

    private func performSearch(searchTerm: String) {
        guard currentSearchTerm != searchTerm else { return }
        currentSearchTerm = searchTerm

        if searchTerm == "" {
            results = []
            return
        }

        currentSearch = OpenCageRequest.search(term: searchTerm)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.delegate?.show(error: error)
                }
            } receiveValue: { [weak self] response in
                self?.ingest(response: response)
            }
    }

    private func ingest(response: OpenCageResponse) {
        results = response.results
    }
}

extension SearchViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? SearchTableViewCell else {
            fatalError("Couldn't dequeue cell")
        }

        cell.result = results[indexPath.row]

        return cell
    }
}

extension SearchViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = results[indexPath.row]
        delegate?.selected(result: result)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SearchTableViewCell.intrinsicContentHeight
    }
}

protocol SearchViewModelDelegate: class {
    func selected(result: OpenCageResponseResult)
    func reloadTable()
    func show(error: Error)
}
