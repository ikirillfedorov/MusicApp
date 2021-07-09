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
	
	var presenter: SearchPresentationLogic?
	var service: SearchService?
	
	func makeRequest(request: Search.Model.Request.RequestType) {
		if service == nil {
			service = SearchService()
		}
		
		switch request {
		case .some:
			print("")
		case .getTracks:
			print("getTracks")
			presenter?.presentData(response: .presentTracks)
		}
	}
}
