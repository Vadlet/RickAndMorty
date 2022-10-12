//
//  EpisodeTableViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

protocol EpisodeTableViewControllerProtocol: AnyObject {
    func reloadTable()
}

final class EpisodeTableViewController: UITableViewController {
    
    // MARK: Private Properties
    
    private let presenter: EpisodePresentingProtocol
    private let cellID = R.string.cellID.episodeTableViewController()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Initializers
    
    init(_ presenter: EpisodePresentingProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.fetchData()
        setupSearchController()
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        title = R.string.titles.episodes()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
    }
}

// MARK: - Search Controller

extension EpisodeTableViewController: UISearchResultsUpdating {
    
    // MARK: - Public Methods
    
    func  updateSearchResults (for searchController: UISearchController) {
        presenter.updateSearch(for: searchController)
    }
    
    // MARK: - Private Methods
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = R.string.titles.search()
        navigationItem.searchController = searchController
    }
}

// MARK: - CharacterTableViewControllerProtocol

extension EpisodeTableViewController: EpisodeTableViewControllerProtocol {
    
    // MARK: - Public Methods
    
    func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: Table view data source

extension EpisodeTableViewController {
    
    // MARK: - Override Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return presenter.filteredEpisodes.count
        } else {
            return presenter.episodes.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        var item: Episode?
        
        if isFiltering {
            item = presenter.filteredEpisodes[indexPath.row]
        } else {
            item = presenter.episodes[indexPath.row]
        }
        
        cell.configure(with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.viewModel = presenter.returnDetailViewModel(indexPath: indexPath)
        present(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.heightCell
    }
}
