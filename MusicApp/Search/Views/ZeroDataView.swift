//
// Copyright © 2021 CleverPumpkin. All rights reserved.
//

import UIKit

final class ZeroDataView: UIView {
	
	// MARK: - Private properties
	
	private lazy var titleLabel = makeTitleLabel()
	
	// MARK: - Initialization
	
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	// MARK: - Private methods
	
	private func setupUI() {
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
}

private extension ZeroDataView {
	func makeTitleLabel() -> UILabel {
		let label = UILabel()
		label.text = "Please enter search term above..."
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		return label
	}
}
