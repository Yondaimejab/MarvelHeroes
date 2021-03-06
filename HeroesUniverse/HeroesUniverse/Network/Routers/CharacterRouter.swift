//
//  CharacterRouter.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

public typealias MarvelCharacterHttpResponse = HttpResponse<ApiClientListResponse<MarvelCharacter>>

enum CharacterRouter: Router {
	case listCharacters(offset: Int, limit: Int)

	var path: String {
		switch self {
		case .listCharacters: return "/characters"
		}
	}

	var method: HTTPMethod {
		switch self {
		case .listCharacters: return .GET
		}
	}

	var parameters: Parameters {
		switch self {
		case let .listCharacters(offset, limit): return ["offset": "\(offset)", "limit": "\(limit)"]
		}
	}
}
