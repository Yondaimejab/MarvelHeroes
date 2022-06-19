//
//  Request.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

enum HTTPMethod: String {
	case GET
	case PUT
	case POST
}

protocol ApiRequest {
	associatedtype Response

	var method: HTTPMethod { get }
	var path: String { get }
	var body: Data? { get }

	func handle(response: Data) throws -> Response
}
