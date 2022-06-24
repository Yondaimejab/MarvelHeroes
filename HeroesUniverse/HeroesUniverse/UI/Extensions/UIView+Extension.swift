//
//  UIView+Extension.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 22/6/22.
//

import UIKit
import Nuke

extension UIView {
	public func loadImage(from url: URL, with placeholder: String, into imageView: UIImageView) {
		let placeholderImageView = UIImage(systemName: placeholder)
		let options = ImageLoadingOptions(
			placeholder: placeholderImageView,
			transition: .fadeIn(duration: 0.33),
			failureImage: placeholderImageView
		)
		Nuke.loadImage(with: url, options: options, into: imageView)
	}

	public func loadImage(from url: URL, assetsPlaceholder placeholder: String, into imageView: UIImageView) {
		let placeholderImageView = UIImage(named: placeholder)
		let options = ImageLoadingOptions(
			placeholder: placeholderImageView,
			transition: .fadeIn(duration: 0.33),
			failureImage: placeholderImageView
		)
		Nuke.loadImage(with: url, options: options, into: imageView)
	}
}
