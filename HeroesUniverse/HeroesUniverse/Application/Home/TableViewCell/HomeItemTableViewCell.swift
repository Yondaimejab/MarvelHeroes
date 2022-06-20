//
//  HomeItemTableViewCell.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import UIKit
import Nuke

class HomeItemTableViewCell: UITableViewCell {
	static let identifier: String = "HomeItemTableViewCell"

	@IBOutlet var label: UILabel!
	@IBOutlet var secondLabel: UILabel!
	@IBOutlet var badgeView: BadgeView!
	@IBOutlet var captionLabel: UILabel!
	@IBOutlet var profileImageView: UIImageView!
	@IBOutlet var imageContainerView: UIView!
	@IBOutlet var imageShadowView: UIView!

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

    override func awakeFromNib() {
		super.awakeFromNib()
		configureView()
		imageContainerView.layer.maskedCorners = .all
		imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
		imageContainerView.backgroundColor = .clear
		imageShadowView.layer.maskedCorners = .all
		imageShadowView.layer.shadowColor = UIColor.black.cgColor
		imageShadowView.layer.shadowOpacity = 0.5
		imageShadowView.layer.shadowOffset = .zero
		imageShadowView.layer.shadowRadius = imageShadowView.frame.height / 12
		let cornerRadius = imageShadowView.frame.height / 2
		imageShadowView.layer.cornerRadius = cornerRadius
		imageShadowView.layer.shadowPath = UIBezierPath(
			roundedRect: imageShadowView.bounds,
			cornerRadius: cornerRadius
		).cgPath
    }

	func configureView() {
		backgroundColor = .clear
		contentView.subviews.first?.layer.maskedCorners = .all
		contentView.subviews.first?.layer.cornerRadius = 12.0
	}

	func configureView(with character: MarvelCharacter) {
		label.text = character.name
		secondLabel.text = character.description
		secondLabel.isHidden = character.description.isEmpty
		if let badgeText = badgeText(for: character) {
			badgeView.isHidden = false
			badgeView.value = badgeText
		} else {
			badgeView.isHidden = true
		}
		captionLabel.text = "This Character has \(character.series?.available ?? 0) series"
		loadImageForCell()
	}

	private func badgeText(for character: MarvelCharacter) -> String? {
		if let comicsAvailable = character.comics?.available, comicsAvailable > 0 {
			return "\(comicsAvailable) comics"
		} else if let storiesAvailable = character.stories?.available, storiesAvailable > 0 {
			return "\(storiesAvailable) stories"
		} else {
			return nil
		}
	}

	private func loadImageForCell() {
		let urlString = "https://randomuser.me/api/portraits/thumb/men/\(Int.random(in: 1...10)).jpg"
		guard let url = URL(string: urlString) else { return }
		let options = ImageLoadingOptions(
			placeholder: UIImage(systemName: "person.fill"),
			transition: .fadeIn(duration: 0.33),
			failureImage: UIImage(systemName: "person.fill")
		)
		Nuke.loadImage(with: url, options: options, into: profileImageView)
	}
}
