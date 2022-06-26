//
//  ImageWithTitleView.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 22/6/22.
//

import Foundation
import UIKit
import Anchorage

@IBDesignable
class ImageWithTitleView: UIView {
	var imageURL: URL?
	var title: String = ""

	@IBOutlet var contentView: UIView!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var mainStackView: UIStackView!

	init(title: String, imageURL: URL?) {
		super.init(frame: .zero)
		initFromNib()
		self.titleLabel.text = title
		self.imageURL = imageURL
		self.configureView()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		initFromNib()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initFromNib()
	}

	func initFromNib() {
		let nib = UINib(nibName: String(describing: ImageWithTitleView.self), bundle: .main)
		nib.instantiate(withOwner: self)
		contentView.frame = bounds
		addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.edgeAnchors == edgeAnchors
		configureView()
	}

	override class func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
	}

	func configureView() {
		mainStackView.layer.maskedCorners = .allCorners
		mainStackView.layer.cornerRadius = CALayer.mediumSizeCornerRadius
		guard let url = imageURL else { return }
		imageView.loadImage(from: url, with: "doc.richtext.fill", into: imageView)
	}
}
