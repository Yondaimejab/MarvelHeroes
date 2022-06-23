//
//  InfoItemView.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 22/6/22.
//

import Foundation
import UIKit
import Anchorage

class InfoItemView: UIView {
	var itemName = ""
	var infoItem: ItemInfo?

	@IBOutlet var itemTitleLabel: UILabel!
	@IBOutlet var contentView: UIView!
	@IBOutlet var itemsContainerStackView: UIStackView!

	override init(frame: CGRect) {
		super.init(frame: frame)
		initFromNib()
	}

	init(infoItem: ItemInfo?, itemName: String) {
		self.itemName = itemName
		self.infoItem = infoItem
		super.init(frame: .zero)
		initFromNib()
		configureView(for: self.infoItem)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initFromNib()
	}

	func initFromNib() {
		let nib = UINib(nibName: String(describing: InfoItemView.self), bundle: .main)
		nib.instantiate(withOwner: self)
		contentView.frame = bounds
		addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.edgeAnchors == edgeAnchors
	}

	func configureView(for infoItem: ItemInfo?) {
		itemsContainerStackView.subviews.forEach { $0.removeFromSuperview() }
		guard let infoItem = infoItem else { return }
		itemTitleLabel.text = "this character has \(infoItem.available) available \(itemName)"
		infoItem.items.forEach {
			var url = URLComponents(string: $0.resourceURI)
			url?.queryItems = MarvelApiClient.shared.authHeadersQueryItems(for: MarvelApiClient.shared.environment)
			let imageWithTitleView = ImageWithTitleView(title: $0.name, imageURL: url?.url)
			itemsContainerStackView.addArrangedSubview(imageWithTitleView)
		}
	}
}
