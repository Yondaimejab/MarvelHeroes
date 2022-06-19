//
//  ApiClientRequestTest.swift
//  HeroesUniverseTests
//
//  Created by joel Alcantara on 19/6/22.
//

import XCTest
@testable import HeroesUniverse

class ApiClientRequestTest: XCTestCase {
	func testCharactersApiClientRequest() throws {
		let apiClient = MarvelApiClient(session: .shared, environment: .development)
		let apiRequest = ApiClientRequest<MarvelCharacterHttpResponse>(router: CharacterRouter.listCharacters)
		let networkExpectation = expectation(description: "BackgroundWorkForApiCall")
		let cancelable = apiClient.publisherForRequest(apiRequest)
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
}
