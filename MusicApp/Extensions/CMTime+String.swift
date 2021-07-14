//
// Copyright © 2021 CleverPumpkin. All rights reserved.
//

import Foundation
import AVKit

extension CMTime {
	var toDisplayString: String {
		guard !CMTimeGetSeconds(self).isNaN else {
			return ""
		}
		let totalSeconds = Int(CMTimeGetSeconds(self))
		let seconds = totalSeconds % 60
		let minutes = totalSeconds / 60
		return String(format: "%02d:%02d", minutes, seconds)
	}
}
