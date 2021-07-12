//
// Copyright © 2021 CleverPumpkin. All rights reserved.
//

import UIKit

final class SearchFooterView: UIView {
	
	// MARK: - Private properties
	
	private lazy var titleLabel = makeTitleLabel()
	private lazy var loader = makeLoader()
	
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
	
	func showLoader() {
		loader.startAnimating()
		titleLabel.text = "Loading"
	}
	
	func hideLoader() {
		loader.stopAnimating()
		titleLabel.text = ""
	}
	
	// MARK: - Private methods
	
	private func setupUI() {
		addSubview(loader)
		loader.snp.makeConstraints {
			$0.top.equalToSuperview().offset(CGFloat.spacing8)
			$0.leading.trailing.equalToSuperview().inset(CGFloat.spacing16)
		}
		
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(loader.snp.bottom).offset(CGFloat.spacing8)
		}
	}
}

private extension SearchFooterView {
	func makeTitleLabel() -> UILabel {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .lightGray
		return label
	}
	
	func makeLoader() -> UIActivityIndicatorView {
		let loader = UIActivityIndicatorView()
		loader.translatesAutoresizingMaskIntoConstraints = false
		loader.hidesWhenStopped = true
		return loader
	}
}
