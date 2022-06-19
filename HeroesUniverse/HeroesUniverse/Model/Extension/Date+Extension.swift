//
//  Date+Extension.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

extension Date {
	var currentTimeMilliSeconds: Int64 { Int64(self.timeIntervalSince1970 * 1000) }
}
