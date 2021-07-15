//
// Copyright © 2021 CleverPumpkin. All rights reserved.
//

import SwiftUI
import URLImage


struct LibraryCell: View {
	
	// MARK: - Private types
	
	private enum Constants {
		static let imageSize = CGSize(width: 60, height: 60)
	}
	
	let cell: TrackModel
	
	var body: some View {
		HStack {
			if let url = URL(string: cell.trackImageUrlString ?? "") {
				URLImage(url) { image in
					image
						.resizable()
						.frame(width: Constants.imageSize.width, height: Constants.imageSize.height)
						.cornerRadius(CGFloat.spacing8)
				}
				.frame(width: Constants.imageSize.width, height: Constants.imageSize.height)
				.cornerRadius(CGFloat.spacing8)
			}
			VStack {
				Text(cell.trackName ?? "")
					.frame(maxWidth: .infinity, alignment: .leading)
				Text(cell.artistName)
					.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
	}
}
