//
//  SceneDelegate.swift
//  command
//
//  Created by Александр Александрович on 08.06.2022.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                AppMainCoordinator(window: self.window!).start()
            } else {
                AppCoordinator.init(window: self.window!).start()
            }
            
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

