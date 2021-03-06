//
//  SceneDelegate.swift
//  MusicApp
//
//  Created by Kirill on 05.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		window.makeKeyAndVisible()
		window.rootViewController = MainTabBarVC()
		self.window = window
	}
}

