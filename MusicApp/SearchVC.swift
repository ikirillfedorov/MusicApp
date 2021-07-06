//
//  SearchVC.swift
//  MusicApp
//
//  Created by Kirill on 05.07.2021.
//

import UIKit
import Alamofire

final class SearchVC: UITableViewController {
	
	private var tracks = [TrackModel]()
	private var timer: Timer?
	
	let searchController = UISearchController(searchResultsController: nil)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		searchController.searchBar.delegate = self
		registerCells()
		setupSearchBar()
	}
	
	private func registerCells() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
	}
	
	private func setupSearchBar() {
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
	}
	
	private func makeURL(searchText: String) -> URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "itunes.apple.com"
		components.path = "/search"
		components.queryItems = [
			URLQueryItem(name: "term", value: searchText)
		]
		return components.url
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tracks.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
		let model = tracks[indexPath.row]
		cell.imageView?.image = UIImage(named: "search_ic")
		cell.textLabel?.text = model.artistName
		cell.detailTextLabel?.text = model.trackName
		return cell
	}
}

// MARK: UISearchBarDelegate

extension SearchVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
			guard let url = self?.makeURL(searchText: searchText) else {
				return
			}
			AF.request(url).response { [weak self] response in
				if let error = response.error {
					print(error.localizedDescription)
					return
				} else if let data = response.data {
					do {
						let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
						self?.tracks = searchResponse.results
						self?.tableView.reloadData()
					} catch {
						print(error.localizedDescription)
					}
				}
			}
		})
	}
}
