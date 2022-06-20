//
//  CACornerMask.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 20/6/22.
//

import Foundation
import QuartzCore

extension CACornerMask {
	static var all: CACornerMask = [
		CACornerMask.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner
	]
}
