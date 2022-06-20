//
//  Character.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

public struct MarvelCharacter: Decodable {
	var id: Int = 0
	var name: String = ""
	var description: String = ""
	private var thumbnail: ThumbnailInfo
	var imageUrlString: String { thumbnail.path + thumbnail.fileExtension }
}
