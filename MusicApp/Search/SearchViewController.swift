//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Kirill on 09.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
	func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
	
	// MARK: - Private types
	
	private enum Constants {
		static let zeroDataHeaderViewHeight: CGFloat = 250
	}
	
	var interactor: SearchBusinessLogic?
	var router: (NSObjectProtocol & SearchRoutingLogic)?
	
	@IBOutlet private weak var tableView: UITableView!
	private let zeroDataView = ZeroDataView()
	private let searchFooterView = SearchFooterView()
	private let searchController = UISearchController(searchResultsController: nil)
	
	private var tracks = [TrackModel]()
	private var timer: Timer?
	private let networkService = NetworkService()
	
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
		tableView.separatorColor = .clear
		tableView.tableFooterView = searchFooterView
	}
	
	func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
		switch viewModel {
		case let .displayTracks(tracksModel):
			tracks = tracksModel
			tableView.reloadData()
			searchFooterView.hideLoader()
		case .displayFooterView:
			searchFooterView.showLoader()
		}
	}
	
	// MARK: - Private methods
	
	private func registerCells() {
		tableView.register(TrackCell.self, forCellReuseIdentifier: TrackCell.reuseIdentifier)
	}
	
	private func setupSearchBar() {
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		searchController.searchBar.delegate = self
		searchController.obscuresBackgroundDuringPresentation = false
	}
	
	private func getTrack(isNext: Bool) -> TrackModel? {
		guard let indexPath = tableView.indexPathForSelectedRow else {
			return nil
		}
		tableView.deselectRow(at: indexPath, animated: true)
		var nextIndexPath: IndexPath?
		if isNext {
			nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
			if indexPath.row == tracks.count - 1 {
				nextIndexPath?.row = 0
			}
		} else {
			nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
			if indexPath.row == 0 {
				nextIndexPath?.row = tracks.count - 1
			}
		}
		tableView.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
		guard let nextIndex = nextIndexPath?.row else {
			return nil
		}
		return tracks[nextIndex]
	}
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tracks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TrackCell.self)
		let model = tracks[indexPath.row]
		cell.configure(model: model)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cellViewModel = tracks[indexPath.row]
		let trackDetailsVC = TrackDetailsVC()
		trackDetailsVC.delegate = self
		trackDetailsVC.modalPresentationStyle = .fullScreen
		trackDetailsVC.rootView.configure(model: cellViewModel)
		present(trackDetailsVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 84
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return zeroDataView
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return tracks.isEmpty ? Constants.zeroDataHeaderViewHeight : 0
	}
}

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
			self?.interactor?.makeRequest(request: .getTracks(searchText: searchText))
		})
	}
}


// MARK: - TrackMovingDelegate

extension SearchViewController: TrackMovingDelegate {
	func moveBackToPreviousTrack() -> TrackModel? {
		return getTrack(isNext: false)
	}
	
	func moveForwardToNextTrack() -> TrackModel? {
		return getTrack(isNext: true)
	}
}
