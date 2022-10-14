//
//  CharacterTableViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

protocol CharacterTableViewControllerProtocol: AnyObject {
    func reloadTable()
}

final class CharacterTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    private let presenter: CharacterPresentingProtocol
    private let cellID = R.string.cellID.characterTableViewController()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var myRefreshControl = UIRefreshControl()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Initializers
    
    init(_ presenter: CharacterPresentingProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.errors.initCoderHasNotBeenImplemented())
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.fetchData()
        setupSearchController()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        title = R.string.titles.characters()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.refreshControl = myRefreshControl
        myRefreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc
    private func refresh(sender: UIRefreshControl) {
        presenter.fetchData()
        sender.endRefreshing()
    }
}

// MARK: - Search Controller

extension CharacterTableViewController: UISearchResultsUpdating {
    
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

extension CharacterTableViewController: CharacterTableViewControllerProtocol {
    
    // MARK: - Public Methods
    
    func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension CharacterTableViewController {
    
    // MARK: - Override Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return presenter.filteredCharacters.count
        } else {
            return presenter.characters.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        var item: Character?
        
        if isFiltering {
            item = presenter.filteredCharacters[indexPath.row]
        } else {
            item = presenter.characters[indexPath.row]
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
