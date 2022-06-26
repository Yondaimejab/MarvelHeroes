//
//  ApiClient.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation
import Combine

struct MarvelApiClient {
	static let shared = MarvelApiClient(session: .shared, environment: .development)
	let session: URLSession
	let environment: ApiEnvironment

	private init(session: URLSession = .shared, environment: ApiEnvironment = .production) {
		self.session = session
		self.environment = environment
	}

	func publisherForRequest<T: ApiRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
		let urlString = (environment.baseURL?.absoluteString ?? "") + request.path
		var requestURL = URLComponents(string: urlString)
		requestURL?.queryItems = queryItemsFor(request, using: environment)
		guard let url = requestURL?.url else { return errorPublisher(for: request, apiClientError: .invalidURL) }
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = request.method.rawValue
		urlRequest.httpBody = request.method != .GET ? request.body : nil
		let publisher = session.dataTaskPublisher(for: urlRequest)
			.tryMap { data, response -> Data in
				guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
					let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
					throw ApiClientError.requestFailed(statusCode)
				}
				return data
			}
			.tryMap { data -> T.Response in return try request.handle(response: data) }
			.tryCatch { error -> AnyPublisher<T.Response, Error> in throw ApiClientError.postProcessingFailed(error) }
			.receive(on: RunLoop.main)
			.eraseToAnyPublisher()
		return publisher
	}

	public func queryItemsFor<T: ApiRequest>(_ request: T, using environment: ApiEnvironment) -> [URLQueryItem] {
		var queryItems: [URLQueryItem] = []
		let timeStamp = "\(Date().currentTimeMilliSeconds)"
		let hash = MD5(string: timeStamp + environment.marvelPrivateKey + environment.marvelPublicKey)
		queryItems = [
			URLQueryItem(name: "apikey", value: environment.marvelPublicKey),
			URLQueryItem(name: "ts", value: timeStamp),
			URLQueryItem(name: "hash", value: hash)
		]
		guard  let body = request.body else { return queryItems }
		guard let dict = try? JSONSerialization.jsonObject(with: body) as? [String: String] else { return queryItems }
		queryItems.append(
			contentsOf: dict.compactMap { item in URLQueryItem(name: item.key, value: item.value) }
		)
		return queryItems
	}

	// TODO: - ADD unit testing for this method
	public func authHeadersQueryItems(for environment: ApiEnvironment) -> [URLQueryItem] {
		var queryItems: [URLQueryItem] = []
		let timeStamp = "\(Date().currentTimeMilliSeconds)"
		let hash = MD5(string: timeStamp + environment.marvelPrivateKey + environment.marvelPublicKey)
		queryItems = [
			URLQueryItem(name: "apikey", value: environment.marvelPublicKey),
			URLQueryItem(name: "ts", value: timeStamp),
			URLQueryItem(name: "hash", value: hash)
		]
		return queryItems
	}

	private func errorPublisher<T: ApiRequest>(
		for request: T,
		apiClientError error: ApiClientError
	) -> AnyPublisher<T.Response, Error> {
		return Future<T.Response, Error> { promise in promise(.failure(error)) }.eraseToAnyPublisher()
	}
}
