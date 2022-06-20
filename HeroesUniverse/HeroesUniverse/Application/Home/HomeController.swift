//
//  HomeController.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

extension HomeViewController {
	func fetchListOfMarvelCharacters(offset: Int, limit: Int) {
		isLoadingNextPage = true
		MarvelCharacterStore.listMarvelCharacters(offset: currentOffset * pageSize, limit: limit)
			.sink { completion in
				switch completion {
				case .finished: print("Completed")
				case .failure(let error): print(error.localizedDescription)
				}
			} receiveValue: { [weak self] apiClientResponse in
				guard let self = self else { return }
				self.didLoadMarvelCharacters(apiClientResponse.data.results)
			}
			.store(in: &cancelableList)
	}

	func didLoadMarvelCharacters(_ characters: [MarvelCharacter]) {
		appendValuesToDataSource(marvelCharacters: characters)
		isLoadingNextPage = false
	}
}
