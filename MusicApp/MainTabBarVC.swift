//
//  MainTabBarVC.swift
//  MusicApp
//
//  Created by Kirill on 05.07.2021.
//

import UIKit
import SwiftUI

final class MainTabBarVC: UITabBarController {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	private func setupUI() {
		let library = Library()
		let hostVC = UIHostingController(rootView: library)
		let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
		
		viewControllers = [
			makeViewController(searchVC, title: "Search", imageTitle: "search"),
			hostVC
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
