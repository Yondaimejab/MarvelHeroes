//
//  HashHelper.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation
import CryptoKit

func MD5(string: String) -> String {
	let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
	return digest.map { String(format: "%02hhx", $0) }.joined()
}
