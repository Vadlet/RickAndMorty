//
//  EpisodeTableViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

protocol EpisodeTableViewControllerProtocol: AnyObject {
    func showAlert(_ error: String)
    func reloadTable()
    var episodes: InfoEpisode? { get set }
    var filteredEpisodes: [Episode] { get set }
}

final class EpisodeTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var episodes: InfoEpisode?
    var filteredEpisodes: [Episode] = []
    
    // MARK: Private Properties
    
    private let presenter: EpisodePresentingProtocol
    private let cellID = CellID.episodeTableViewController
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
        title = Titles.episodes
        view.backgroundColor = .white
        tableView.separatorStyle = .none
    }
}

// MARK: - Search Controller

extension EpisodeTableViewController: UISearchResultsUpdating {
    
    // MARK: - Public Methods
    
    func  updateSearchResults (for searchController: UISearchController) {
        presenter.updateSearchEpisode(for: searchController)
    }
    
    // MARK: - Private Methods
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Titles.search
        navigationItem.searchController = searchController
    }
}

// MARK: - CharacterTableViewControllerProtocol

extension EpisodeTableViewController: EpisodeTableViewControllerProtocol {
    
    // MARK: - Public Methods
    
    func showAlert(_ error: String) {
        failedAlert(massage: error.localizedCapitalized)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: Table view data source

extension EpisodeTableViewController {
    
    // MARK: - Override Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredEpisodes.count
        } else {
            return episodes?.results.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        var episodes: Episode?
        
        if isFiltering {
            episodes = filteredEpisodes[indexPath.row]
        } else {
            episodes = self.episodes?.results[indexPath.row]
        }
        
        cell.configure(with: episodes)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.heightCell
    }
}
