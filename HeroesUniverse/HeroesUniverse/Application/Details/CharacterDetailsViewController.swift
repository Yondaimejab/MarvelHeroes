//
//  HeroeDetailsViewController.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 20/6/22.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
	public var marvelCharacter: MarvelCharacter?

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	func configureView(with character: MarvelCharacter? = nil) {
		guard let marvelCharacter = character else { return }
		print(marvelCharacter.id)
	}
}
