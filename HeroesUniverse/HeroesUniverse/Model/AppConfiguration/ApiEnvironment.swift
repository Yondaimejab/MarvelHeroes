//
//  Environment.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

enum ApiEnvironment: String {
	case development, staging, production

    private var baseURLAbsoluteString: String {
		switch self {
		case .development: return "https://example.com/api/v1"
		case .staging: return "http://localhost:8080/api/v1"
		case .production: return "https://localhost:8080/api/v1"
		}
    }

    public var baseURL: URL? { URL(string: baseURLAbsoluteString) }
}
