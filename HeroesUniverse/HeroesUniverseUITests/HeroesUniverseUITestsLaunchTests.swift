//
//  HeroesUniverseUITestsLaunchTests.swift
//  HeroesUniverseUITests
//
//  Created by joel Alcantara on 19/6/22.
//

import XCTest

class HeroesUniverseUITestsLaunchTests: XCTestCase {
	override class var runsForEachTargetApplicationUIConfiguration: Bool {
		true
	}

	override func setUpWithError() throws {
		_ = try? super.setUpWithError()
		continueAfterFailure = false
	}

	func testLaunch() throws {
		let app = XCUIApplication()
		app.launch()
		// Insert steps here to perform after app launch but before taking a screenshot,
		// such as logging into a test account or navigating somewhere in the app
		let attachment = XCTAttachment(screenshot: app.screenshot())
		attachment.name = "Launch Screen"
		attachment.lifetime = .keepAlways
		add(attachment)
	}
}
