//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Kirill on 09.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
	func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
	
	var networkService = NetworkService()
	var presenter: SearchPresentationLogic?
	var service: SearchService?
	
	func makeRequest(request: Search.Model.Request.RequestType) {
		if service == nil {
			service = SearchService()
		}
		
		switch request {
		case let .getTracks(searchText):
			presenter?.presentData(response: .presentFooterView)
			networkService.fetchTracks(searchText: searchText) { [weak self] searchResponse in
				self?.presenter?.presentData(response: .presentTracks(searchResponse: searchResponse))
			}
		}
	}
}
