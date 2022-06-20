//
//  MarvelCharacterStore.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation
import Combine

public enum MarvelCharacterStore {
	static func listMarvelCharacters(offset: Int, limit: Int) -> AnyPublisher<MarvelCharacterHttpResponse, Error> {
		let router = CharacterRouter.listCharacters(offset: offset, limit: limit)
		let apiRequest = ApiClientRequest<MarvelCharacterHttpResponse>(router: router)
		return MarvelApiClient.shared.publisherForRequest(apiRequest)
	}
}
