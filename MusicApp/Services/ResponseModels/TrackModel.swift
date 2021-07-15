//
//  TrackModel.swift
//  MusicApp
//
//  Created by Kirill on 06.07.2021.
//

import Foundation
import SwiftUI

struct TrackModel: Codable, Identifiable {
	let id: Int
	let trackName: String?
	let collectionName: String?
	let artistName: String
	let trackImageUrlString: String?
	let previewUrl: String?
	
	private enum CodingKeys : String, CodingKey {
		case trackName
		case collectionName
		case artistName
		case trackImageUrlString = "artworkUrl100"
		case previewUrl
		case id = "trackId"
	}
}
