//
//  HomeItemTableViewCell.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import UIKit
import Nuke

class HomeItemTableViewCell: UITableViewCell {
	enum DrawingConstants {
		static let shadowOpacity: Float = 0.5
	}

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
		displayDefaultLayout()
    }

	private func displayDefaultLayout() {
		backgroundColor = .clear
		contentView.subviews.first?.layer.maskedCorners = .all
		contentView.subviews.first?.layer.cornerRadius = CALayer.mediumSizeCornerRadius
		imageContainerView.layer.maskedCorners = .all
		imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
		imageContainerView.backgroundColor = .clear
		imageShadowView.layer.maskedCorners = .all
		imageShadowView.layer.shadowColor = UIColor.black.cgColor
		imageShadowView.layer.shadowOpacity = DrawingConstants.shadowOpacity
		imageShadowView.layer.shadowOffset = .zero
		let cornerRadius = imageShadowView.frame.height / 2
		imageShadowView.layer.shadowRadius = cornerRadius
		imageShadowView.layer.cornerRadius = cornerRadius
		let shadowPath = UIBezierPath(roundedRect: imageShadowView.bounds, cornerRadius: cornerRadius).cgPath
		imageShadowView.layer.shadowPath = shadowPath
	}

	func configureView(for character: MarvelCharacter) {
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
		let urlString = "https://randomuser.me/api/portraits/thumb/men/\(Int.random(in: 1...10)).jpg"
		guard let url = URL(string: urlString) else { return }
		profileImageView.loadImage(from: url, with: "person.fill", into: profileImageView)
	}

	private func badgeText(for character: MarvelCharacter) -> String? {
		if let comicsAvailable = character.comics?.available, comicsAvailable > 0 {
			return "\(comicsAvailable) comics"
		} else if let storiesAvailable = character.stories?.available, storiesAvailable > 0 {
			return "\(storiesAvailable) stories"
		}
		return nil
	}
}
