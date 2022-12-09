//
//  SceneDelegate.swift
//  Fruit-Game
//
//  Created by Samreth Kem on 12/4/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        DB.shared.save()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        DB.shared.save()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        DB.shared.save()
    }
}

