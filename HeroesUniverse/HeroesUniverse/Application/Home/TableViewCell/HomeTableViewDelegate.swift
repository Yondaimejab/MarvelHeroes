//
//  HomeTableViewDelegate.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 20/6/22.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate {
	enum DrawingConstant {
		static let contentOffsetReference: CGFloat = 100
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let marvelCharacter = dataSource?.itemIdentifier(for: indexPath) else { return }
		selectedCharacter = marvelCharacter
		performSegue(withIdentifier: Segue.details.rawValue, sender: self)
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let height = scrollView.frame.size.height
		let contentYoffset = scrollView.contentOffset.y
		let distanceFromBottom = scrollView.contentSize.height - contentYoffset
		if distanceFromBottom < height, !isLoadingNextPage, !isFilteringResults {
			currentOffset += 1
			fetchListOfMarvelCharacters(offset: currentOffset, limit: pageSize)
		}
	}
}
