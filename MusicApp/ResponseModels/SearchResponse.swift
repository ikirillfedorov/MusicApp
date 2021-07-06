//
//  SearchResponse.swift
//  MusicApp
//
//  Created by Kirill on 06.07.2021.
//

import Foundation

struct SearchResponse: Decodable {
	let resultCount: Int
	let results: [TrackModel]
}
