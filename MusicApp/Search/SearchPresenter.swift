//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Kirill on 09.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
	func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
	weak var viewController: SearchDisplayLogic?
	
	func presentData(response: Search.Model.Response.ResponseType) {
		switch response {
		case let .presentTracks(searchResults):
			viewController?.displayData(viewModel: .displayTracks(tracks: searchResults?.results ?? []))
		case .presentFooterView:
			viewController?.displayData(viewModel: .displayFooterView)
		}
	}
}
