//
//  MainTabBarVC.swift
//  MusicApp
//
//  Created by Kirill on 05.07.2021.
//

import UIKit

final class MainTabBarVC: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	private func setupUI() {
		viewControllers = [
			makeViewController(SearchVC(), title: "Search", imageTitle: "search_ic"),
			makeViewController(LibraryVC(), title: "Library", imageTitle: "library_ic")
		]
	}
	
	private func makeViewController(_ rootVC: UIViewController, title: String, imageTitle: String) -> UIViewController {
		let navVC = UINavigationController(rootViewController: rootVC)
		navVC.tabBarItem.image = UIImage(named: imageTitle)
		navVC.tabBarItem.title = title
		rootVC.navigationItem.title = title
		navVC.navigationBar.prefersLargeTitles = true
		return navVC
	}
}
