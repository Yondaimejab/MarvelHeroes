//
//  Router.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

typealias Parameters = [String: Any]?

protocol Router {
	var path: String { get }
	var method: HTTPMethod { get }
	var parameters: Parameters { get }
}
