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
	private let networkService = NetworkService()
	
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
			self?.networkService.fetchTracks(searchText: searchText, completion: { [weak self] response in
				self?.tracks = response?.results ?? []
				self?.tableView.reloadData()
			})
		})
	}
}
