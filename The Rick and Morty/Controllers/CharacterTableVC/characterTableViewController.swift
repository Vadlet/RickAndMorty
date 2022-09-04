//
//  CharacterTableViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

protocol CharacterTableViewControllerProtocol: AnyObject {
    var characters: InfoCharacter? { get set }
    var filteredCharacters: [Character] { get set }
    func showAlert(_ error: String)
    func reloadTable()
}

final class CharacterTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var characters: InfoCharacter?
    var filteredCharacters: [Character] = []
    
    // MARK: - Private Properties
    
    private let presenter: CharacterPresentingProtocol
    private let cellID = CellID.characterTableViewController
    private let searchController = UISearchController(searchResultsController: nil)
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.fetchData()
        setupSearchController()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        title = Titles.characters
        view.backgroundColor = .white
        tableView.separatorStyle = .none
    }
}

// MARK: - Search Controller

extension CharacterTableViewController: UISearchResultsUpdating {
    
    // MARK: - Public Methods
    
    func  updateSearchResults (for searchController: UISearchController) {
        presenter.updateSearchCharacter(for: searchController)
    }
    
    // MARK: - Private Methods
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Titles.search
        navigationItem.searchController = searchController
    }
}

// MARK: - CharacterTableViewControllerProtocol

extension CharacterTableViewController: CharacterTableViewControllerProtocol {
    
    // MARK: - Public Methods
    
    func showAlert(_ error: String) {
        failedAlert(massage: error.localizedCapitalized)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension CharacterTableViewController {
    
    // MARK: - Override Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCharacters.count
        } else {
            return characters?.results.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        var characters: Character?
        
        if isFiltering {
            characters = filteredCharacters[indexPath.row]
        } else {
            characters = self.characters?.results[indexPath.row]
        }
        
        cell.configure(with: characters)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.heightCell
    }
}
