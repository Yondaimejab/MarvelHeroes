//
//  ThumbnailInfo.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

public struct ThumbnailInfo: Decodable {
	enum CodingKeys: String, CodingKey {
		case path
		case fileExtension = "extension"
	}

	var path: String = ""
	var fileExtension: String = ""
}
