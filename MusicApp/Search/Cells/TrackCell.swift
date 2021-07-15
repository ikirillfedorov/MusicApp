//
// Copyright © 2021 CleverPumpkin. All rights reserved.
//

import UIKit
import SnapKit
import Reusable
import Kingfisher

final class TrackCell: UITableViewCell, Reusable {
	
	//MARK: - Private types
	
	private enum Constants {
		static let trackImageSize = CGSize(width: 60, height: 60)
	}
	
	// MARK: - Internal properties
	
	private(set) lazy var trackImageView = makeTrackImageView()
	private(set) lazy var trackNameLabel = makeTrackNameLabel()
	private(set) lazy var artistNameLabel = makeArtistNameLabel()
	private(set) lazy var collectionNameLabel = makeAlbumNameLabel()
	private(set) lazy var addButton = makeAddButton()
	
	// MARK: - Private properties
	
	private var currentModel: TrackModel?
	
	// MARK: - Initialization
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	// MARK: - Internal methods
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView?.image = nil
		addButton.isHidden = false
	}
	
	func configure(model: TrackModel) {
		let inFavorites = StorageService.tracks.first { $0.id == self.currentModel?.id } != nil
		addButton.isHidden = inFavorites
		currentModel = model
		trackNameLabel.text = model.trackName
		artistNameLabel.text = model.artistName
		collectionNameLabel.text = model.collectionName
		guard
			let urlString = model.trackImageUrlString,
			let url = URL(string: urlString)
		else {
			return
		}
		trackImageView.kf.setImage(with: url, placeholder: UIImage(named: "track_placeholder"))
	}
	
	// MARK: - Private methods
	
	private func setupUI() {
		selectionStyle = .none
		
		contentView.addSubview(trackImageView)
		trackImageView.snp.makeConstraints {
			$0.top.leading.bottom.equalToSuperview().inset(CGFloat.spacing12)
			$0.size.equalTo(Constants.trackImageSize)
		}
		
		contentView.addSubview(trackNameLabel)
		trackNameLabel.snp.makeConstraints {
			$0.leading.equalTo(trackImageView.snp.trailing).offset(CGFloat.spacing8)
			$0.top.equalTo(trackImageView.snp.top)
			$0.trailing.equalToSuperview().inset(CGFloat.spacing44)
		}
		
		contentView.addSubview(artistNameLabel)
		artistNameLabel.snp.makeConstraints {
			$0.leading.equalTo(trackImageView.snp.trailing).offset(CGFloat.spacing8)
			$0.top.equalTo(trackNameLabel.snp.bottom).offset(CGFloat.spacing2)
			$0.trailing.equalToSuperview().inset(CGFloat.spacing44)
		}
		
		contentView.addSubview(collectionNameLabel)
		collectionNameLabel.snp.makeConstraints {
			$0.leading.equalTo(trackImageView.snp.trailing).offset(CGFloat.spacing8)
			$0.top.equalTo(artistNameLabel.snp.bottom).offset(CGFloat.spacing2)
			$0.trailing.equalToSuperview().inset(CGFloat.spacing44)
		}
		
		contentView.addSubview(addButton)
		addButton.snp.makeConstraints {
			$0.centerY.equalToSuperview()
			$0.trailing.equalToSuperview().inset(CGFloat.spacing16)
		}
	}
	
	// MARK: - Actions
	
	@objc
	private func addButtonTapped() {
		StorageService.addTrack(track: currentModel)
		addButton.isHidden = true
	}
}

// MARK: - Factory

private extension TrackCell {
	func makeTrackImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = CGFloat.spacing8
		imageView.layer.masksToBounds = true
		imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
		imageView.setContentHuggingPriority(.required, for: .horizontal)
		imageView.image = UIImage(named: "track_placeholder")
		return imageView
	}
	
	func makeTrackNameLabel() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 17, weight: .medium)
		return label
	}
	
	func makeAlbumNameLabel() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 13, weight: .medium)
		label.textColor = .lightGray
		return label
	}
	
	func makeArtistNameLabel() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 13, weight: .medium)
		label.textColor = .lightGray
		return label
	}
	
	func makeAddButton() -> UIButton {
		let button = UIButton(type: .system)
		let image = UIImage(named: "Add")
		button.setImage(image, for: .normal)
		button.tintColor = .red
		button.setContentCompressionResistancePriority(.required, for: .horizontal)
		button.setContentHuggingPriority(.required, for: .horizontal)
		button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
		return button
	}
}
