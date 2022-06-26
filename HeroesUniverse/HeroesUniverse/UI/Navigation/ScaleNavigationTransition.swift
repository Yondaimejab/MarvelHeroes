//
//  FadeNavigationTransition.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 21/6/22.
//

import UIKit
import Nuke

class ScaleNavigationTransition: NSObject, UIViewControllerAnimatedTransitioning {
	let duration = 1.0
	var isPresentingViewToAnimate = true
	var originFrame = CGRect.zero

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return duration
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let fromView = transitionContext.view(forKey: .from) else { return }
		guard let toView = transitionContext.view(forKey: .to) else { return }
		let containerView = transitionContext.containerView
		let viewToAnimate = isPresentingViewToAnimate ? toView : fromView
		animation(viewToAnimate: viewToAnimate, containerView: containerView, context: transitionContext)
	}

	private func pushAnimation(
		viewToAnimate view: UIView,
		containerView: UIView,
		context: UIViewControllerContextTransitioning
	) {
		containerView.addSubview(view)
		view.alpha = 0.0
		UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
			view.alpha = 1.0
		}, completion: { _ in
			context.completeTransition(true)
		})
	}

	private func animation(
		viewToAnimate view: UIView,
		containerView: UIView,
		context: UIViewControllerContextTransitioning
	) {
		let initialFrame = isPresentingViewToAnimate ? originFrame : view.frame
		let finalFrame = isPresentingViewToAnimate ? view.frame : originFrame
		let widthDivision = initialFrame.width / finalFrame.width
		let widthDivisionReversed = finalFrame.width / initialFrame.width
		let xScaleFactor = isPresentingViewToAnimate ? widthDivision : widthDivisionReversed
		let heightDivision = initialFrame.height / finalFrame.height
		let heightDivisionReversed = finalFrame.height / initialFrame.height
		let yScaleFactor = isPresentingViewToAnimate ? heightDivision : heightDivisionReversed
		let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
		if isPresentingViewToAnimate {
			view.transform = scaleTransform
			view.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
			view.clipsToBounds = true
		}
		if let toView = context.view(forKey: .to) {
			containerView.addSubview(toView)
		}
		containerView.bringSubviewToFront(view)
		containerView.layer.maskedCorners = .allCorners
		if !isPresentingViewToAnimate { containerView.alpha = 1 }
		UIView.animate(
			withDuration: duration,
			delay: 0.0,
			usingSpringWithDamping: 0.6,
			initialSpringVelocity: 0.0,
			options: self.isPresentingViewToAnimate ? .curveEaseOut : .curveEaseIn,
			animations: {
				view.transform = self.isPresentingViewToAnimate ? CGAffineTransform.identity : scaleTransform
				view.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
				view.alpha = self.isPresentingViewToAnimate ? 1 : 0
			}, completion: { _ in context.completeTransition(true) }
		)
		UIView.animate(withDuration: duration / 2) {
			view.layer.cornerRadius = self.isPresentingViewToAnimate ? 0.0 : 12 / xScaleFactor
		}
	}
}
