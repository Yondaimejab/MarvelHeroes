//
//  ApiClientRequestTest.swift
//  HeroesUniverseTests
//
//  Created by joel Alcantara on 19/6/22.
//

import XCTest
@testable import HeroesUniverse

class MarvelApiClientTest: XCTestCase {
	func testCharactersApiClientRequest() throws {
		let characterRouter = CharacterRouter.listCharacters(offset: 0, limit: 10)
		let apiRequest = ApiClientRequest<MarvelCharacterHttpResponse>(router: characterRouter)
		let networkExpectation = expectation(description: "BackgroundWorkForApiCall")
		let cancelable = MarvelApiClient.shared.publisherForRequest(apiRequest)
			.sink { completion in
				switch completion {
				case .finished:
					XCTAssertTrue(Thread.current.isMainThread, "Result called on backgroundThread")
					networkExpectation.fulfill()
				case .failure(let error):
					print(error.localizedDescription)
					XCTAssertTrue(false)
				}
			} receiveValue: { value in
				XCTAssertTrue(!value.data.results.isEmpty)
			}
		wait(for: [networkExpectation], timeout: 15)
		cancelable.cancel()
	}

	func testQueryItems() {
		let environment = MarvelApiClient.shared.environment
		let headers = MarvelApiClient.shared.authHeadersQueryItems(for: environment)
		let authCompleted = headers.map { $0.name }.allSatisfy { header in
			header == "apikey" || header == "ts" || header == "hash"
		}
		XCTAssertTrue(authCompleted)
	}

	func testGetRequestHeaders() throws {
		let characterRouter = CharacterRouter.listCharacters(offset: 0, limit: 10)
		XCTAssertNotNil(characterRouter.parameters)
		let parameterKeys = try XCTUnwrap(characterRouter.parameters).keys
		let apiRequest = ApiClientRequest<MarvelCharacterHttpResponse>(router: characterRouter)
		let environment = MarvelApiClient.shared.environment
		let queryItems = MarvelApiClient.shared.queryItemsFor(apiRequest, using: environment)
		XCTAssertFalse(queryItems.isEmpty)
		let queryItemKeys = queryItems.map { $0.name }
		let requestParametersSet = parameterKeys.allSatisfy { parameterKey in
			return queryItemKeys.contains(parameterKey)
		}
		XCTAssertTrue(requestParametersSet)
	}
}
