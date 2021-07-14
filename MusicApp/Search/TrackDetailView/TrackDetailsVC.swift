//
//  TrackDetailsVC.swift
//  MusicApp
//
//  Created by Kirill on 12.07.2021.
//

import UIKit
import AVKit

protocol TrackMovingDelegate: AnyObject {
	func moveBackToPreviousTrack() -> TrackModel?
	func moveForwardToNextTrack() -> TrackModel?
}

final class TrackDetailsVC<RootView>: UIViewController, HasRootView where RootView: TrackDetailsView {
	
	// MARK: - Typealias
	
	typealias RootView = TrackDetailsView
	
	// MARK: - Internal properties
	
	weak var delegate: TrackMovingDelegate?
	
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
	
	private func observePlayerCurrentTime() {
		let interval = CMTimeMake(value: 1, timescale: 2)
		player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
			self?.rootView.trackTimeLeadingLabel.text = time.toDisplayString
			let durationTime = self?.player.currentItem?.duration
			let currentDurationText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString
			self?.rootView.trackTimeTrailingLabel.text = "-\(currentDurationText)"
			self?.updateCurrentTimeSlider()
		}
	}
	
	private func updateCurrentTimeSlider() {
		let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
		let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
		let percentage = Float(currentTimeSeconds / durationSeconds)
		rootView.trackSlider.value = percentage
	}
}

// MARK: - TrackDetailsViewDelegate

extension TrackDetailsVC: TrackDetailsViewDelegate {
	func dragDownButtonTapped(_ sender: UIButton) {
		dismiss(animated: true)
	}
	
	func handleTrackSlider(_ sender: UISlider) {
		let percentage = sender.value
		guard let duration = player.currentItem?.duration else {
			return
		}
		let durationInSeconds = CMTimeGetSeconds(duration)
		let seekTimeInSeconds = Float64(percentage) * durationInSeconds
		let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
		player.seek(to: seekTime)
	}
	
	func handleVolumeSlider(_ sender: UISlider) {
		player.volume = sender.value
	}
	
	func previousTrackTapped(_ sender: UIButton) {
		guard let model = delegate?.moveBackToPreviousTrack() else {
			return
		}
		self.rootView.configure(model: model)
	}
	
	func nextTrackTapped(_ sender: UIButton) {
		guard let model = delegate?.moveForwardToNextTrack() else {
			return
		}
		self.rootView.configure(model: model)
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
	
	func viewConfigured(_ sender: TrackDetailsView) {
		playTrack()
		monitorStartTime()
		observePlayerCurrentTime()
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
