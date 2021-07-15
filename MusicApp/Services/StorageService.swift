//
// Copyright © 2021 CleverPumpkin. All rights reserved.
//

import Foundation

enum StorageService {
	static var tracks: [TrackModel] {
		guard
			let tracksData = UserDefaults.standard.object(forKey: .udTracksKey) as? Data,
			let tracks = try? JSONDecoder().decode([TrackModel].self, from: tracksData)
		else {
			return []
		}
		return tracks
	}
	
	static func addTrack(track: TrackModel?) {
		guard let addedTrack = track else {
			return
		}
		var listOfTracks = StorageService.tracks
		listOfTracks.append(addedTrack)
		guard let data = try? JSONEncoder().encode(listOfTracks) else {
			return
		}
		UserDefaults.standard.set(data, forKey: .udTracksKey)
	}
	
	static func remove(at index: Int) {
		var listOfTracks = StorageService.tracks
		listOfTracks.remove(at: index)
		guard let data = try? JSONEncoder().encode(listOfTracks) else {
			return
		}
		UserDefaults.standard.set(data, forKey: .udTracksKey)
	}
}
