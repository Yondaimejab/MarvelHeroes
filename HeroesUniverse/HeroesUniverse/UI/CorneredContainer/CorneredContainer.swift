//
//  CorneredContainer.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 25/6/22.
//

import UIKit
import Anchorage

@IBDesignable
public class CorneredContainer: UIView {
	var cornerMask: CACornerMask = .none {
		didSet {
			contentView.layer.maskedCorners = cornerMask
		}
	}

	@IBInspectable var cornerRadius: CGFloat {
		get { contentView.layer.cornerRadius }
		set { contentView.layer.cornerRadius = newValue }
	}

	@IBInspectable var contentBackground: UIColor? {
		get { contentView.backgroundColor }
		set { contentView.backgroundColor = newValue }
	}

	@IBInspectable var maskCorners: Bool {
		get { cornerMask == .allCorners }
		set { if newValue { cornerMask = .allCorners } }
	}

	@IBOutlet var contentView: UIView!

	override init(frame: CGRect) {
		super.init(frame: frame)
		initFromNib()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initFromNib()
	}

	func initFromNib() {
		let nib = UINib(nibName: String(describing: CorneredContainer.self), bundle: .main)
		nib.instantiate(withOwner: self)
		contentView.frame = bounds
		addSubview(contentView)
		self.backgroundColor = .clear
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.edgeAnchors == edgeAnchors
	}

	public override class func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
	}
}
