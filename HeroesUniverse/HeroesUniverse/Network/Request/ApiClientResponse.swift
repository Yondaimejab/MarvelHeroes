//
//  ApiClientResponse.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

public struct ApiClientListResponse<T: Decodable>: Decodable {
	var offset: Int
	var limit: Int
	var total: Int
	var count: Int
	var results: [T]
}

public struct HttpResponse<T: Decodable>: Decodable {
	var code: Int
	var data: T
}
