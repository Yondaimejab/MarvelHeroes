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
		case .development: return "https://gateway.marvel.com/v1/public"
		case .staging: return "https://gateway.marvel.com/v1/public"
		case .production: return "https://gateway.marvel.com/v1/public"
		}
    }

    public var baseURL: URL? { URL(string: baseURLAbsoluteString) }
	public var marvelPublicKey: String { return "cdd409c0602361a2312707c8c8642462" }
	public var marvelPrivateKey: String { return "499207529b4fa90dee943cd1204cf9ea02f5b5b4" }
}
