//
//  UITextField+Extension.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 23/6/22.
//

import UIKit
import Combine

extension UITextField {
	var textChangedPublisher: AnyPublisher<String, Never> {
		NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
			.compactMap { ($0.object as? UITextField)?.text }
			.eraseToAnyPublisher()
	}
}
