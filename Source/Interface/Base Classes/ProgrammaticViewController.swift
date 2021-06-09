//
//  ProgrammaticViewController.swift
//

import UIKit
import Combine

class ProgrammaticViewController: UIViewController {
    // MARK: - Init

    let dependencies: Dependencies

    required init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Unused")
    required init(coder aDecoder: NSCoder) { fatalError("Not defined") }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        registerEvents()
        bind()
    }

    var debugging_onViewDidAppear: (() -> Void)?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugging_onViewDidAppear?()
    }

    // MARK: - Register Events, Bindings

    var subscriptions: Set<AnyCancellable> = []

    /// Register 
    func registerEvents() {}

    /// Configure reactive bindings
    func bind() {}

    // MARK: - Presenting

    func newViewController<T: ProgrammaticViewController>() -> T {
        dependencies.coordinator.newViewController(dependencies: dependencies)
    }

    // MARK: - Error

    func show(error: Error) {
        productionPrint(error)
        let viewController = UIAlertController(title: .error, message: error.localizedDescription, preferredStyle: .alert)
        viewController.addAction(.init(title: .dismiss, style: .default, handler: nil))
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - Localized Strings

fileprivate extension String {
    static let error = NSLocalizedString("ERROR_TITLE", value: "Error", comment: "Title on error alert")
    static let dismiss = NSLocalizedString("ERROR_DISMISS", value: "Dismiss", comment: "Button on error alert")
}
