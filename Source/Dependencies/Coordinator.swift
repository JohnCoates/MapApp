//
//  Coordinator.swift
//

import UIKit

final class Coordinator {
    var window: UIWindow!

    func bootstrap(dependencies: Dependencies) {
        let viewController = navigatableViewController(type: SearchViewController.self, dependencies: dependencies)
        present(viewController: viewController)
    }

    private func present(viewController: UIViewController) {
        window.rootViewController = viewController
        present(window: window)
    }

    private func present(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
    }

    func newViewController<T: ProgrammaticViewController>(dependencies: Dependencies) -> T {
        T(dependencies: dependencies)
    }

    func navigatableViewController<T: ProgrammaticViewController>(type: T.Type,
                                                                  dependencies: Dependencies) -> UINavigationController {
        let rootViewController = newViewController(dependencies: dependencies) as T
        return UINavigationController(rootViewController: rootViewController)
    }
}
