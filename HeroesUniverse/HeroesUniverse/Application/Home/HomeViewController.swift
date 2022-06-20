//
//  HomeViewController.swift
//  HeroesUniverse
//
//  Created by joel Alcantara on 19/6/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
	typealias MarvelHeroesDataSource = UITableViewDiffableDataSource<Section, MarvelCharacter>

	enum Section {
		case main
	}

	enum Segue: String {
		case details = "showCharacterDetails"
	}

	let pageSize = 10
	var currentOffset = 0
	var cancelableList = Set<AnyCancellable>()
	var dataSource: MarvelHeroesDataSource?
	var selectedCharacter: MarvelCharacter?
	var isLoadingNextPage = false

	@IBOutlet var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		configureTableView()
		fetchListOfMarvelCharacters(offset: currentOffset, limit: pageSize)
	}

	func configureTableView() {
		let nib = UINib(nibName: "HomeItemTableViewCell", bundle: nil)
		tableView.separatorStyle = .none
		tableView.rowHeight = UITableView.automaticDimension
		tableView.register(nib, forCellReuseIdentifier: HomeItemTableViewCell.identifier)
		tableView.delegate = self
		dataSource = MarvelHeroesDataSource(tableView: tableView) { tableView, indexPath, hero in
			let cell = tableView.dequeueReusableCell(withIdentifier: HomeItemTableViewCell.identifier, for: indexPath)
			guard let cell = cell as? HomeItemTableViewCell else {
				fatalError("Could not dequeue cell for identifier: \(HomeItemTableViewCell.identifier)")
			}
			cell.configureView(with: hero)
			return cell
		}
		tableView.dataSource = dataSource
	}

	private func createDataSourceSnapshot(marvelCharacters: [MarvelCharacter]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, MarvelCharacter>()
		snapshot.appendSections([.main])
		snapshot.appendItems(marvelCharacters, toSection: .main)
		dataSource?.apply(snapshot, animatingDifferences: true)
	}

	func appendValuesToDataSource(marvelCharacters: [MarvelCharacter]) {
		guard let dataSource = dataSource else { return }
		var snapshot = dataSource.snapshot()
		guard snapshot.numberOfItems > 0 else { return createDataSourceSnapshot(marvelCharacters: marvelCharacters) }
		snapshot.appendItems(marvelCharacters)
		dataSource.apply(snapshot, animatingDifferences: true)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segue.details.rawValue {
			guard let destination = segue.destination as? CharacterDetailsViewController else { return }
			destination.marvelCharacter = selectedCharacter
		}
	}
}
