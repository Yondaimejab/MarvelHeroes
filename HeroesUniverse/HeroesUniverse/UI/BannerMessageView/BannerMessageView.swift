//
//  BannerMessageView.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 26/6/22.
//

import UIKit
import Anchorage

@IBDesignable
class BannerMessageView: UIView {
	@IBInspectable var contentBackground: UIColor? {
		get { contentView.backgroundColor }
		set { contentView.backgroundColor = newValue }
	}

	@IBInspectable var cornerRadius: CGFloat {
		get { contentView.layer.cornerRadius }
		set { contentView.layer.cornerRadius = newValue }
	}

	@IBInspectable var labelText: String? {
		get { messageLabel.text }
		set { messageLabel.text = newValue }
	}

	@IBOutlet var contentView: UIView!
	@IBOutlet var corneredContainer: UIView!
	@IBOutlet var messageLabel: UILabel!

	override init(frame: CGRect) {
		super.init(frame: frame)
		initFromNib()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initFromNib()
	}

	func initFromNib() {
		let nib = UINib(nibName: String(describing: BannerMessageView.self), bundle: .main)
		nib.instantiate(withOwner: self)
		contentView.frame = bounds
		addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.edgeAnchors == edgeAnchors
	}

	override class func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
	}
}
