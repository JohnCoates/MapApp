//
//  ResultViewController.swift
//  6/9/21
//

import UIKit

final class ResultViewController: ProgrammaticViewController {
    @Forward(\ResultViewController.viewModel.result)
    var result: OpenCageResponseResult?
    
    private let viewModel = ResultViewModel()

    // MARK: - View Lifecycle

    private var _view: ResultView!

    override func loadView() {
        _view = .init()
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = .title
    }

    // MARK: - Register Events, Bindings

    override func bind() {
        viewModel.$webViewUrl.receive(on: DispatchQueue.main)
            .sink { [weak self] url in
                if let url = url {
                    self?._view.webView.load(.init(url: url))
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Localized Strings

fileprivate extension String {
    static let title = NSLocalizedString("MAP_TITLE",
                                         value: "Map",
                                         comment: "Title on map screen")
}
