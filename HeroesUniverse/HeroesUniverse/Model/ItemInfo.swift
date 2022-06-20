//
//  ComicInfo.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 20/6/22.
//

import Foundation

struct ItemInfo: Decodable {
	struct Item: Decodable {
		var name: String = ""
	}
	var available: Int = 0
	var items: [Item]
}
