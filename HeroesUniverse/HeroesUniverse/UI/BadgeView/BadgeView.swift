//
//  BadgeView.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 20/6/22.
//

import Foundation
import UIKit
import Anchorage

class BadgeView: UIView {
	@IBInspectable var badgeBackground: UIColor {
		get { contentView.backgroundColor ?? .clear }
		set { contentView.backgroundColor = newValue
			self.backgroundColor = newValue
		}
	}
	@IBInspectable var value: String {
		get { valueLabel.text ?? "" }
		set { valueLabel.text = newValue }
	}
	@IBOutlet var contentView: UIView!
	@IBOutlet var valueLabel: UILabel!

	override init(frame: CGRect) {
		super.init(frame: frame)
		initFromNib()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initFromNib()
	}

	func initFromNib() {
		let nib = UINib(nibName: String(describing: BadgeView.self), bundle: .main)
		nib.instantiate(withOwner: self)
		contentView.frame = bounds
		addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.edgeAnchors == edgeAnchors
		configureView()
	}

	func configureView() {
		let maskedCorners: CACornerMask = [
			.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner
		]
		layer.maskedCorners = maskedCorners
		contentView.layer.maskedCorners = maskedCorners
		layer.cornerRadius = frame.size.height / 2
		contentView.layer.cornerRadius = contentView.frame.size.height / 2
	}
}
