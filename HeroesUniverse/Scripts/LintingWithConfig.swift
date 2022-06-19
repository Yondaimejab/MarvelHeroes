//
//  LintingWithConfig.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

@main
enum LintingWithConfig {
	static func main() {
		startLinting(allowedWarnings: 1)
	}

	static func startLinting(allowedWarnings: Int = 0) {
		let lintResult = shell("swiftlint --config Scripts/swiftlint.yml")
		print(lintResult)
		var logResult = lintResult
			.components(separatedBy: "Done linting!").last ?? "Found 0"
		logResult = logResult.trimmingCharacters(in: CharacterSet(charactersIn: " "))
			.components(separatedBy: " ")[1]
		let foundViolations = Int(logResult) ?? 0
		if foundViolations > allowedWarnings {
			let firstLine = "Error: Violations allowed exceed limit. Limit is \(allowedWarnings)"
			let nextLine = "violations, Found \(foundViolations)!"
			print(firstLine + nextLine)
			exit(1)
		}
		exit(0)
	}
}
