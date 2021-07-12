//
//  TrackDetailsView.swift
//  MusicApp
//
//  Created by Kirill on 12.07.2021.
//

import UIKit

final class TrackDetailsView: UIView {
	
	// MARK: - Private properties
	
	private lazy var dragDownButton = makeDragDownButton()
	private lazy var trackImageView = makeTrackImageView()
	private lazy var trackSlider = makeTrackSlider()
	private lazy var trackTimeLeadingLabel = makeTrackTimeLeadingLabel()
	private lazy var trackTimeTralingLabel = makeTrackTimeTralingLabel()
	private lazy var trackNameLabel = makeTrackNameLabel()
	private lazy var artistNameLabel = makeArtistNameLabel()
	private lazy var trackControlStackView = makeTrackControlStackView()
	private lazy var forwardArrowButton = makeForwardArrowButton()
	private lazy var backdArrowButton = makeBackdArrowButton()
	private lazy var playButton = makePlayButton()
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
	
	// MARK: - Private methods
	
	private func setupUI() {
		backgroundColor = .white
		
		addSubview(dragDownButton)
		dragDownButton.snp.makeConstraints {
			$0.top.equalTo(safeAreaLayoutGuide).offset(CGFloat.spacing8)
			$0.centerX.equalToSuperview()
		}
		
		addSubview(trackImageView)
		trackImageView.snp.makeConstraints {
			$0.top.equalTo(dragDownButton.snp.bottom).offset(CGFloat.spacing8)
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing16)
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
		
		addSubview(trackTimeTralingLabel)
		trackTimeTralingLabel.snp.makeConstraints {
			$0.top.equalTo(trackSlider.snp.bottom).offset(CGFloat.spacing2)
			$0.trailing.equalTo(trackSlider.snp.trailing)
		}
		
		addSubview(trackNameLabel)
		trackNameLabel.snp.makeConstraints {
			$0.top.equalTo(trackSlider.snp.bottom).offset(CGFloat.spacing44)
			$0.centerX.equalToSuperview()
		}
		
		addSubview(artistNameLabel)
		artistNameLabel.snp.makeConstraints {
			$0.top.equalTo(trackNameLabel.snp.bottom).offset(CGFloat.spacing16)
			$0.centerX.equalToSuperview()
		}
		
		addSubview(trackControlStackView)
		trackControlStackView.snp.makeConstraints {
			$0.top.equalTo(artistNameLabel.snp.bottom).offset(CGFloat.spacing44)
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing16)
		}
		
		trackControlStackView.addArrangedSubview(backdArrowButton)
		trackControlStackView.addArrangedSubview(playButton)
		trackControlStackView.addArrangedSubview(forwardArrowButton)
		
		addSubview(trackVolumeStackView)
		trackVolumeStackView.snp.makeConstraints {
			$0.top.equalTo(trackControlStackView.snp.bottom).offset(CGFloat.spacing44)
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing16)
			$0.bottom.equalTo(safeAreaLayoutGuide).inset(CGFloat.spacing16)
		}
		
		
		trackVolumeStackView.addArrangedSubview(minVolumeImageView)
		trackVolumeStackView.addArrangedSubview(volumeSlider)
		trackVolumeStackView.addArrangedSubview(maxVolumeImageView)

		
		trackVolumeStackView.addArrangedSubview(minVolumeImageView)
		trackVolumeStackView.addArrangedSubview(volumeSlider)
		trackVolumeStackView.addArrangedSubview(maxVolumeImageView)
	}
}

// MARK: - Factory

private extension TrackDetailsView {
	func makeDragDownButton() -> UIButton {
		let button = UIButton()
		button.setImage(UIImage(named: "Drag Down"), for: .normal)
		return button
	}
	func makeTrackImageView() -> UIImageView {
		let imageView = UIImageView()
		return imageView
	}
	func makeTrackSlider() -> UISlider {
		let slider = UISlider()
		return slider
	}
	func makeTrackTimeLeadingLabel() -> UILabel {
		let label = UILabel()
		return label

	}
	func makeTrackTimeTralingLabel() -> UILabel {
		let label = UILabel()
		return label

	}
	func makeTrackNameLabel() -> UILabel {
		let label = UILabel()
		label.text = "Test Track Name"
		label.font = .systemFont(ofSize: 24, weight: .semibold)
		return label

	}
	func makeArtistNameLabel() -> UILabel {
		let label = UILabel()
		label.text = "Test Artist"
		label.font = .systemFont(ofSize: 24)
		label.textColor = .red
		return label
	}
	func makeTrackControlStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.distribution = .fillEqually
		stackView.alignment = .center
		return stackView
	}
	
	func makeForwardArrowButton() -> UIButton {
		let button = UIButton()
		button.setImage(UIImage(named: "Right"), for: .normal)
		return button
	}
	func makeBackdArrowButton() -> UIButton {
		let button = UIButton()
		button.setImage(UIImage(named: "Left"), for: .normal)
		return button

	}
	func makePlayButton() -> UIButton {
		let button = UIButton()
		button.setImage(UIImage(named: "play"), for: .normal)
		return button
	}
	
	func makeTrackVolumeStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.spacing = CGFloat.spacing8
		return stackView
	}
	
	func makeVolumeSlider() -> UISlider {
		let slider = UISlider()
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
