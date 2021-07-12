//
//  TrackDetailsVC.swift
//  MusicApp
//
//  Created by Kirill on 12.07.2021.
//

import UIKit

final class TrackDetailsVC<RootView>: UIViewController, HasRootView where RootView: TrackDetailsView {
	typealias RootView = TrackDetailsView
	
	override func loadView() {
		view = RootView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
