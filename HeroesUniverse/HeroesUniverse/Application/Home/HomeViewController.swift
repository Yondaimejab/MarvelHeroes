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
	let scaleTransition = ScaleNavigationTransition()
	var tableData: [MarvelCharacter] = []
	var isFilteringResults: Bool {
		!(searchBar.searchTextField.text?.isEmpty ?? true)
	}

	@IBOutlet var searchBar: UISearchBar!
	@IBOutlet var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		configureTableView()
		fetchListOfMarvelCharacters(offset: currentOffset, limit: pageSize)
		subscribeToEvents()
	}

	func subscribeToEvents() {
		searchBar.searchTextField.textChangedPublisher.sink { [weak self] text in
			guard let self = self else { return }
			guard !text.isEmpty else { return self.createDataSourceSnapshot(marvelCharacters: self.tableData) }
			self.createFilterSnapshot(for: text)
		}
		.store(in: &cancelableList)
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
			cell.configureView(for: hero)
			return cell
		}
		tableView.dataSource = dataSource
	}

	private func createDataSourceSnapshot(marvelCharacters: [MarvelCharacter]) {
		tableData = marvelCharacters
		var snapshot = NSDiffableDataSourceSnapshot<Section, MarvelCharacter>()
		snapshot.appendSections([.main])
		snapshot.appendItems(marvelCharacters, toSection: .main)
		dataSource?.apply(snapshot, animatingDifferences: true)
	}

	func appendValuesToDataSource(marvelCharacters: [MarvelCharacter]) {
		guard let dataSource = dataSource else { return }
		var snapshot = dataSource.snapshot()
		guard snapshot.numberOfItems > 0 else { return createDataSourceSnapshot(marvelCharacters: marvelCharacters) }
		tableData.append(contentsOf: marvelCharacters)
		snapshot.appendItems(marvelCharacters)
		dataSource.apply(snapshot, animatingDifferences: true)
	}

	// TODO: add unit test for this method
	private func getFilteredCharacters(for searchTerm: String) -> [MarvelCharacter] {
		return self.tableData.filter { marvelCharacter in
			if let number = Int(searchTerm) {
				let equalAmountOfComics = (marvelCharacter.comics?.available ?? 0) == number
				let equalAmountOfSeries = (marvelCharacter.comics?.available ?? 0) == number
				let equalAmountOfStories = (marvelCharacter.comics?.available ?? 0) == number
				return equalAmountOfComics || equalAmountOfSeries || equalAmountOfStories
			} else {
				return marvelCharacter.name.contains(searchTerm)
			}
		}
	}

	func createFilterSnapshot(for searchTerm: String) {
		let filteredCharacters = getFilteredCharacters(for: searchTerm).sorted { $0.name > $1.name }
		var currentSnapshot = dataSource?.snapshot()
		guard currentSnapshot != nil else { return }
		if tableData.count > 1 { currentSnapshot?.deleteAllItems() }
		currentSnapshot?.appendSections([.main])
		currentSnapshot?.appendItems(filteredCharacters, toSection: .main)
		if let snapshot = currentSnapshot { dataSource?.apply(snapshot, animatingDifferences: true) }
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segue.details.rawValue {
			guard let destination = segue.destination as? CharacterDetailsViewController else { return }
			destination.marvelCharacter = selectedCharacter
			destination.modalPresentationStyle = .fullScreen
			destination.transitioningDelegate = self
		}
	}
}
