//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Kirill on 09.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: class {
	func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
	
	var interactor: SearchBusinessLogic?
	var router: (NSObjectProtocol & SearchRoutingLogic)?
	
	@IBOutlet weak var tableView: UITableView!
	let searchController = UISearchController(searchResultsController: nil)

	// MARK: Setup
	
	private func setup() {
		let viewController = self
		let interactor = SearchInteractor()
		let presenter = SearchPresenter()
		let router = SearchRouter()
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
	}
	
	// MARK: Routing
	
	
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		setupSearchBar()
		registerCells()
		tableView.delegate = self
		tableView.dataSource = self
		searchController.searchBar.delegate = self
	}
	
	func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
		switch viewModel {
		case .some:
			print("some")
		case .displayTracks:
			print("displayTracks")
		}
	}
	
	// MARK: - Private methods
	
	private func registerCells() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
	}
	
	private func setupSearchBar() {
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
	}
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
	
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
//		let model = tracks[indexPath.row]
//		cell.imageView?.image = UIImage(named: "search_ic")
//		cell.textLabel?.text = model.artistName
//		cell.detailTextLabel?.text = model.trackName
		return cell
	}
}

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		interactor?.makeRequest(request: .getTracks)
//		timer?.invalidate()
//		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
//			self?.networkService.fetchTracks(searchText: searchText, completion: { [weak self] response in
//				self?.tracks = response?.results ?? []
//				self?.tableView.reloadData()
//			})
//		})
	}
}
