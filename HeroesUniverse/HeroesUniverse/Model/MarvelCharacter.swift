//
//  Character.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

public struct MarvelCharacter: Decodable, Hashable {
	var id: Int = 0
	var name: String = ""
	var description: String = ""
	private var thumbnail: ThumbnailInfo
	var imageUrlString: String { thumbnail.path }
	var comics: ItemInfo?
	var series: ItemInfo?
	var stories: ItemInfo?
	public static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
		return lhs.id == rhs.id && lhs.name == rhs.name && lhs.description == rhs.description
		&& lhs.imageUrlString == rhs.imageUrlString
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
