//
//  UIViewController+Storyboard.swift
//  MusicApp
//
//  Created by Kirill on 09.07.2021.
//

import UIKit

extension UIViewController {
	static func loadFromStoryboard<T: UIViewController>() -> T {
		let name = String(describing: T.self)
		let storyboard = UIStoryboard(name: name, bundle: nil)
		guard let viewController = storyboard.instantiateInitialViewController() as? T else {
			fatalError("No initial view controller in \(name)")
		}
		return viewController
	}
}
