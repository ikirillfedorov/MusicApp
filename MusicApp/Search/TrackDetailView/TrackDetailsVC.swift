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
		monitorStartTime()
		updateCurrentTimeSlider()
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
	
	private func monitorStartTime() {
		let times = [NSValue(time: CMTimeMake(value: 1, timescale: 100))]
		player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
			self?.rootView.animateTrackImage(state: .enlarge)
		}
	}
	
	private func updateCurrentTimeSlider() {
		let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
		let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
		let percentage = Float(currentTimeSeconds / durationSeconds)
		rootView.trackSlider.setValue(percentage, animated: true)
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
		switch player.timeControlStatus {
		case .paused:
			player.play()
			rootView.playButton.setImage(UIImage(named: "pause"), for: .normal)
			rootView.animateTrackImage(state: .enlarge)
		case .playing:
			player.pause()
			rootView.playButton.setImage(UIImage(named: "play"), for: .normal)
			rootView.animateTrackImage(state: .reduce)
		default:
			break
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
