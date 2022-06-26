//
//  CACornerMaskExtension.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 25/6/22.
//

import Foundation
import UIKit
 
extension CACornerMask {
	static let allCorners: CACornerMask = [
		.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner
	]
	static let topCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
	static let bottomCorners: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
	static let leadingCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
	static let trailingCorners: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
	
}
