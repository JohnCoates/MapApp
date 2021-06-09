//
//  SceneDelegate.swift
//  Created on 6/9/21
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let dependencies = Dependencies()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: scene)
        let coordinator = dependencies.coordinator
        coordinator.window = window
        coordinator.bootstrap(dependencies: dependencies)
    }
}

