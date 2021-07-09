//
//  NetworkService.swift
//  Pods
//
//  Created by Kirill on 09.07.2021.
//

import UIKit
import Alamofire

class NetworkService {
	func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
		guard let url = makeURL(searchText: searchText) else {
			return
		}
		AF.request(url).response { response in
			if let error = response.error {
				print(error.localizedDescription)
				return
			} else if let data = response.data {
				do {
					let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
					completion(searchResponse)
				} catch {
					completion(nil)
					print(error.localizedDescription)
				}
			}
		}
	}
	
	private func makeURL(searchText: String) -> URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "itunes.apple.com"
		components.path = "/search"
		components.queryItems = [
			URLQueryItem(name: "term", value: searchText),
			URLQueryItem(name: "limit", value: "50"),
			URLQueryItem(name: "media", value: "music"),
		]
		return components.url
	}
}
