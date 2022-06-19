//
//  PostRequest.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//
//

import Foundation

struct ApiClientRequest<T: Decodable>: ApiRequest {
	typealias Response = T

	var router: Router
	var method: HTTPMethod { router.method }
	var path: String { router.path }
	var body: Data? {
		guard let dictionary = router.parameters else { return nil }
		return try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
	}

	init(router: Router) {
		self.router = router
	}

	func handle(response: Data) throws -> Response {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		return try decoder.decode(Response.self, from: response)
	}
}
