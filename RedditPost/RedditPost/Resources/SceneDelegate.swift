//
//  SceneDelegate.swift
//  RedditPost
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let module = PostModule()
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = module.postViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

