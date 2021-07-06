//
//  SearchVC.swift
//  MusicApp
//
//  Created by Kirill on 05.07.2021.
//

import UIKit

final class SearchVC: UITableViewController {
	
	let array = [
		TrackModel(name: "Test1", artistName: "Test2"),
		TrackModel(name: "Test1", artistName: "Test2"),
		TrackModel(name: "Test1", artistName: "Test2"),
		TrackModel(name: "Test1", artistName: "Test2"),
		TrackModel(name: "Test1", artistName: "Test2")
	]
	
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
		return array.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
		let model = array[indexPath.row]
		cell.imageView?.image = UIImage(named: "search_ic")
		cell.textLabel?.text = model.name
		cell.detailTextLabel?.text = model.name
		return cell
	}
}

// MARK: UISearchBarDelegate

extension SearchVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		print(searchText)
	}
}
