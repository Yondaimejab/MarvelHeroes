//
//  HeroeDetailsViewController.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 20/6/22.
//

import UIKit
import Anchorage

class CharacterDetailsViewController: UIViewController {
	public var marvelCharacter: MarvelCharacter?

	@IBOutlet var characterNameLabel: UILabel!
	@IBOutlet var characterImageView: UIImageView!
	@IBOutlet var infoItemsContainerStackView: UIStackView!
	@IBOutlet var characterDescriptionLabel: UILabel!
	@IBOutlet var imageContainerView: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()
		buildDefaultLayout()
		configureView(with: marvelCharacter)
	}

	@IBAction func dismissView(_ sender: Any) {
		self.dismiss(animated: true)
	}

	func buildDefaultLayout() {
		infoItemsContainerStackView.subviews.forEach { $0.removeFromSuperview() }
		imageContainerView.layer.maskedCorners = .all
		imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
	}

	func configureView(with character: MarvelCharacter? = nil) {
		guard let marvelCharacter = character else { return }
		characterNameLabel.text = marvelCharacter.name
		characterDescriptionLabel.text = marvelCharacter.description
		characterDescriptionLabel.isHidden = marvelCharacter.description.isEmpty
		if let comic = marvelCharacter.comics {
			let comicView = InfoItemView(infoItem: comic, itemName: "Comics")
			infoItemsContainerStackView.addArrangedSubview(comicView)
		}
		if let series = marvelCharacter.series {
			let seriesView = InfoItemView(infoItem: series, itemName: "Series")
			infoItemsContainerStackView.addArrangedSubview(seriesView)
		}
		if let stories = marvelCharacter.stories {
			let storiesView = InfoItemView(infoItem: stories, itemName: "Stories")
			infoItemsContainerStackView.addArrangedSubview(storiesView)
		}
		let urlString = "https://randomuser.me/api/portraits/men/\(Int.random(in: 1...10)).jpg"
		guard let url = URL(string: urlString) else { return }
		characterImageView.loadImage(from: url, with: "person.full", into: characterImageView)
	}
}
