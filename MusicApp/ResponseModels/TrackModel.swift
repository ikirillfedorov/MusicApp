//
//  TrackModel.swift
//  MusicApp
//
//  Created by Kirill on 06.07.2021.
//

import Foundation

struct TrackModel: Decodable {
	let trackName: String?
	let collectionName: String?
	let artistName: String
	let trackImageUrlString: String?
	
	private enum CodingKeys : String, CodingKey {
		case trackName
		case collectionName
		case artistName
		case trackImageUrlString = "artworkUrl100"
	}
}
