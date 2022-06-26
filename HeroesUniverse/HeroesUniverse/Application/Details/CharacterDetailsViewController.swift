//
//  HeroeDetailsViewController.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 20/6/22.
//

import UIKit
import Anchorage

class CharacterDetailsViewController: UIViewController {
	enum DrawingConstants {
		static let shadowOpacity: Float = 0.5
	}

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
		imageContainerView.layer.maskedCorners = .allCorners
		characterImageView.layer.maskedCorners = .allCorners
		let cornerRadius = imageContainerView.frame.height / 2
		imageContainerView.layer.cornerRadius = cornerRadius
		characterImageView.layer.cornerRadius = characterImageView.bounds.height / 2
		imageContainerView.layer.shadowOpacity = DrawingConstants.shadowOpacity
		imageContainerView.layer.shadowColor = UIColor.black.cgColor
		imageContainerView.layer.shadowOffset = .zero
		imageContainerView.layer.shadowRadius = 10
		let shadowPath = UIBezierPath(roundedRect: imageContainerView.bounds, cornerRadius: cornerRadius).cgPath
		imageContainerView.layer.shadowPath = shadowPath
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
		characterImageView.loadImage(from: url, with: "person.fill", into: characterImageView)
	}
}
