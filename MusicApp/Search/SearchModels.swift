//
//  SearchModels.swift
//  MusicApp
//
//  Created by Kirill on 09.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Search {
	
	enum Model {
		struct Request {
			enum RequestType {
				case getTracks(searchText: String)
			}
		}
		struct Response {
			enum ResponseType {
				case presentTracks(searchResponse: SearchResponse?)
				case presentFooterView
			}
		}
		struct ViewModel {
			enum ViewModelData {
				case displayTracks(tracks: [TrackModel])
				case displayFooterView
			}
		}
	}
}
