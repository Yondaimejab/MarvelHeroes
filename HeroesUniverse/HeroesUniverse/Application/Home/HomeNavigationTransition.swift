//
//  HomeNavigationTransition.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 21/6/22.
//

import UIKit

extension HomeViewController: UIViewControllerTransitioningDelegate {
	func animationController(
		forPresented presented: UIViewController,
		presenting: UIViewController,
		source: UIViewController
	) -> UIViewControllerAnimatedTransitioning? {
		if let presentedCharacter = selectedCharacter, let indexPath = dataSource?.indexPath(for: presentedCharacter),
		let cell = tableView.cellForRow(at: indexPath) {
			scaleTransition.originFrame = cell.contentView.convert(cell.contentView.bounds, to: nil)
			cell.contentView.isHidden = true
		}
		scaleTransition.isPresentingViewToAnimate = true
		return scaleTransition
	}

	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		if let presentedCharacter = selectedCharacter, let indexPath = dataSource?.indexPath(for: presentedCharacter),
		let cell = tableView.cellForRow(at: indexPath) {
			cell.contentView.isHidden = false
		}
		scaleTransition.isPresentingViewToAnimate = false
		return scaleTransition
	}
}
