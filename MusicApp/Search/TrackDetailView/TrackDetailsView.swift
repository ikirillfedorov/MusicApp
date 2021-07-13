//
//  TrackDetailsView.swift
//  MusicApp
//
//  Created by Kirill on 12.07.2021.
//

import UIKit
import Kingfisher

enum TrackImageState {
	case enlarge
	case reduce
}

protocol TrackDetailsViewDelegate: AnyObject {
	func dragDownButtonTapped(_ sender: UIButton)
	func handleTrackSlider(_ sender: UISlider)
	func handleVolumeSlider(_ sender: UISlider)
	func previousTrackTapped(_ sender: UIButton)
	func nextTrackTapped(_ sender: UIButton)
	func playTrackTapped(_ sender: UIButton)
}

final class TrackDetailsView: UIView {
	
	// MARK: - Internal properties
	
	private(set) lazy var trackSlider = makeTrackSlider()
	private(set) lazy var playButton = makePlayButton()

	private(set) var trackUrlString: String?
	
	weak var delegate: TrackDetailsViewDelegate?
	
	// MARK: - Private properties
	
	private lazy var dragDownButton = makeDragDownButton()
	private lazy var trackImageView = makeTrackImageView()
	private lazy var trackTimeLeadingLabel = makeTrackTimeLeadingLabel()
	private lazy var trackTimeTrailingLabel = makeTrackTimeTrailingLabel()
	private lazy var trackNameLabel = makeTrackNameLabel()
	private lazy var artistNameLabel = makeArtistNameLabel()
	private lazy var trackControlStackView = makeTrackControlStackView()
	private lazy var forwardArrowButton = makeForwardArrowButton()
	private lazy var backArrowButton = makeBackArrowButton()
	private lazy var trackVolumeStackView = makeTrackVolumeStackView()
	private lazy var volumeSlider = makeVolumeSlider()
	private lazy var minVolumeImageView = makeMinVolumeImageView()
	private lazy var maxVolumeImageView = makeMaxVolumeImageView()
	
	// MARK: - Initialization
	
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	// MARK: - Internal methods
	
	func configure(model: TrackModel) {
		trackNameLabel.text = model.trackName
		artistNameLabel.text = model.artistName
		trackUrlString = model.previewUrl
		let trackImagePlaceholder = UIImage(named: "track_placeholder")
		guard
			let largeImageString = model.trackImageUrlString?.replacingOccurrences(of: "100x100", with: "600x600"),
			let url = URL(string: largeImageString)
		else {
			trackImageView.image = trackImagePlaceholder
			return
		}
		trackImageView.kf.setImage(with: url, placeholder: trackImagePlaceholder)
	}
	
	func animateTrackImage(state: TrackImageState) {
		UIView.animate(
			withDuration: 1,
			delay: 0,
			usingSpringWithDamping: 0.5,
			initialSpringVelocity: 1,
			options: .curveEaseOut) { [weak self] in
			switch state {
			case .enlarge:
				self?.trackImageView.transform = .identity
			case .reduce:
				let scale: CGFloat = 0.8
				self?.trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
			}
		}
	}
	
	// MARK: - Private methods
	
	private func setupUI() {
		animateTrackImage(state: .reduce)
		backgroundColor = .white
		
		addSubview(dragDownButton)
		dragDownButton.snp.makeConstraints {
			$0.top.equalTo(safeAreaLayoutGuide).offset(CGFloat.spacing8)
			$0.centerX.equalToSuperview()
		}
		
		addSubview(trackImageView)
		trackImageView.snp.makeConstraints {
			$0.top.equalTo(dragDownButton.snp.bottom).offset(CGFloat.spacing8)
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing44)
			$0.width.equalTo(trackImageView.snp.height)
		}
		
		addSubview(trackSlider)
		trackSlider.snp.makeConstraints {
			$0.top.equalTo(trackImageView.snp.bottom).offset(CGFloat.spacing16)
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing16)
		}
		
		addSubview(trackTimeLeadingLabel)
		trackTimeLeadingLabel.snp.makeConstraints {
			$0.top.equalTo(trackSlider.snp.bottom).offset(CGFloat.spacing2)
			$0.leading.equalTo(trackSlider.snp.leading)
		}
		
		addSubview(trackTimeTrailingLabel)
		trackTimeTrailingLabel.snp.makeConstraints {
			$0.top.equalTo(trackSlider.snp.bottom).offset(CGFloat.spacing2)
			$0.trailing.equalTo(trackSlider.snp.trailing)
		}
		
		addSubview(trackNameLabel)
		trackNameLabel.snp.makeConstraints {
			$0.top.equalTo(trackSlider.snp.bottom).offset(CGFloat.spacing24)
			$0.centerX.equalToSuperview()
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing16)
		}
		
		addSubview(artistNameLabel)
		artistNameLabel.snp.makeConstraints {
			$0.top.equalTo(trackNameLabel.snp.bottom).offset(CGFloat.spacing16)
			$0.centerX.equalToSuperview()
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing16)
		}
		
		addSubview(trackControlStackView)
		trackControlStackView.snp.makeConstraints {
			$0.top.equalTo(artistNameLabel.snp.bottom).offset(CGFloat.spacing16)
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing16)
		}
		
		trackControlStackView.addArrangedSubview(backArrowButton)
		trackControlStackView.addArrangedSubview(playButton)
		trackControlStackView.addArrangedSubview(forwardArrowButton)
		
		addSubview(trackVolumeStackView)
		trackVolumeStackView.snp.makeConstraints {
			$0.top.equalTo(trackControlStackView.snp.bottom).offset(CGFloat.spacing16)
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing16)
			$0.bottom.equalTo(safeAreaLayoutGuide).inset(CGFloat.spacing16)
		}
		
		playButton.snp.makeConstraints {
			$0.height.equalTo(playButton.snp.width)
		}
		
		trackVolumeStackView.addArrangedSubview(minVolumeImageView)
		trackVolumeStackView.addArrangedSubview(volumeSlider)
		trackVolumeStackView.addArrangedSubview(maxVolumeImageView)

		
		trackVolumeStackView.addArrangedSubview(minVolumeImageView)
		trackVolumeStackView.addArrangedSubview(volumeSlider)
		trackVolumeStackView.addArrangedSubview(maxVolumeImageView)
	}
	
	// MARK: - Actions
	
	@objc
	func dragDownButtonTapped() {
		delegate?.dragDownButtonTapped(dragDownButton)
	}
	
	@objc
	func handleTrackSlider() {
		delegate?.handleTrackSlider(trackSlider)
	}
	
	@objc
	func handleVolumeSlider() {
		delegate?.handleVolumeSlider(volumeSlider)
	}
	
	@objc
	func previousTrackTapped(_ sender: UIButton) {
		delegate?.previousTrackTapped(backArrowButton)
	}
	
	@objc
	func nextTrackTapped(_ sender: UIButton) {
		delegate?.nextTrackTapped(forwardArrowButton)
	}
	
	@objc
	func playTrackTapped(_ sender: UIButton) {
		delegate?.playTrackTapped(playButton)
	}
}

// MARK: - Factory

private extension TrackDetailsView {
	func makeDragDownButton() -> UIButton {
		let button = UIButton()
		button.setImage(UIImage(named: "Drag Down"), for: .normal)
		button.addTarget(
			self,
			action: #selector(dragDownButtonTapped),
			for: .touchUpInside
		)
		return button
	}
	
	func makeTrackImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = CGFloat.spacing16
		imageView.layer.masksToBounds = true
		return imageView
	}
	
	func makeTrackSlider() -> UISlider {
		let slider = UISlider()
		slider.addTarget(
			self,
			action: #selector(handleTrackSlider),
			for: .valueChanged
		)
		return slider
	}
	
	func makeTrackTimeLeadingLabel() -> UILabel {
		let label = UILabel()
		label.text = "00:00"
		label.font = .systemFont(ofSize: 13)
		label.textColor = .lightGray
		return label

	}
	
	func makeTrackTimeTrailingLabel() -> UILabel {
		let label = UILabel()
		label.text = "--:--"
		label.font = .systemFont(ofSize: 13)
		label.textColor = .lightGray
		return label

	}
	
	func makeTrackNameLabel() -> UILabel {
		let label = UILabel()
		label.text = "Test Track Name"
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 24, weight: .semibold)
		return label

	}
	
	func makeArtistNameLabel() -> UILabel {
		let label = UILabel()
		label.text = "Test Artist"
		label.font = .systemFont(ofSize: 24)
		label.textColor = .red
		label.textAlignment = .center
		return label
	}
	
	func makeTrackControlStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.distribution = .fillEqually
		stackView.alignment = .center
		return stackView
	}
	
	func makeForwardArrowButton() -> UIButton {
		let button = UIButton(type: .system)
		button.tintColor = .black
		button.setImage(UIImage(named: "Right"), for: .normal)
		button.addTarget(
			self,
			action: #selector(nextTrackTapped),
			for: .touchUpInside
		)
		return button
	}
	
	func makeBackArrowButton() -> UIButton {
		let button = UIButton(type: .system)
		button.tintColor = .black
		button.setImage(UIImage(named: "Left"), for: .normal)
		button.addTarget(
			self,
			action: #selector(previousTrackTapped),
			for: .touchUpInside
		)
		return button
	}
	
	func makePlayButton() -> UIButton {
		let button = UIButton(type: .system)
		button.tintColor = .black
		button.setImage(UIImage(named: "pause"), for: .normal)
		button.contentMode = .scaleToFill
		button.addTarget(
			self,
			action: #selector(playTrackTapped),
			for: .touchUpInside
		)
		
		return button
	}
	
	func makeTrackVolumeStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.spacing = CGFloat.spacing8
		return stackView
	}
	
	func makeVolumeSlider() -> UISlider {
		let slider = UISlider()
		slider.addTarget(
			self,
			action: #selector(handleVolumeSlider),
			for: .valueChanged
		)
		return slider
	}
	
	func makeMinVolumeImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "Icon Min")
		imageView.contentMode = .center
		return imageView
	}
	
	func makeMaxVolumeImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "Icon Max")
		imageView.contentMode = .center
		return imageView
	}
}
