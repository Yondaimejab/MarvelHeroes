//
//  ViewController.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import UIKit

class ViewController: UIViewController {
	enum Segue: String {
		case showHomeSegue
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		performSegue(withIdentifier: Segue.showHomeSegue.rawValue, sender: self)
	}
}
