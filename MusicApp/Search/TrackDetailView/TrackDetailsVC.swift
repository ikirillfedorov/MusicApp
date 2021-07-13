//
//  TrackDetailsVC.swift
//  MusicApp
//
//  Created by Kirill on 12.07.2021.
//

import UIKit
import AVKit

final class TrackDetailsVC<RootView>: UIViewController, HasRootView where RootView: TrackDetailsView {
	
	// MARK: - Typealias
	
	typealias RootView = TrackDetailsView
	
	// MARK: - Private properties
	
	private lazy var player = makePlayer()
	
	// MARK: - Internal methods
	
	override func loadView() {
		view = RootView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		rootView.delegate = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		playTrack()
	}
	
	// MARK: - Private methods
	
	private func playTrack() {
		guard let url = URL(string: rootView.trackUrlString ?? "") else {
			return
		}
		let playerItem = AVPlayerItem(url: url)
		player.replaceCurrentItem(with: playerItem)
		player.play()
	}
}

// MARK: - TrackDetailsViewDelegate

extension TrackDetailsVC: TrackDetailsViewDelegate {
	func dragDownButtonTapped(_ sender: UIButton) {
		dismiss(animated: true)
	}
	
	func handleTrackSlider(_ sender: UISlider) {
		
	}
	
	func handleVolumeSlider(_ sender: UISlider) {
		
	}
	
	func previousTrackTapped(_ sender: UIButton) {
		
	}
	
	func nextTrackTapped(_ sender: UIButton) {
		
	}
	
	func playTrackTapped(_ sender: UIButton) {
		if player.timeControlStatus == .paused {
			player.play()
			rootView.playButton.setImage(UIImage(named: "pause"), for: .normal)
		} else {
			player.pause()
			rootView.playButton.setImage(UIImage(named: "play"), for: .normal)
		}
	}
}

// MARK: - Factory

private extension TrackDetailsVC {
	func makePlayer() -> AVPlayer {
		let player = AVPlayer()
		player.automaticallyWaitsToMinimizeStalling = false
		return player
	}
}
