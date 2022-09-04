//
//  LocationTableViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

protocol LocationTableViewControllerProtocol: AnyObject {
    func showAlert(_ error: String)
    func reloadTable()
    var locations: InfoLocation? { get set }
    var filteredLocations: [Location] { get set }
}

final class LocationTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var locations: InfoLocation?
    var filteredLocations: [Location] = []
    
    // MARK: - Private Properties
    
    private let presenter: LocationPresentingProtocol
    private let cellID = CellID.locationTableViewController
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Initializers
    
    init(_ presenter: LocationPresentingProtocol) {
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
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        title = Titles.locations
        view.backgroundColor = .white
        tableView.separatorStyle = .none
    }
}

// MARK: - Search Controller

extension LocationTableViewController: UISearchResultsUpdating {
    
    // MARK: - Public Methods
    
    func  updateSearchResults (for searchController: UISearchController) {
        presenter.updateSearchLocation(for: searchController)
    }
    
    // MARK: - Private Methods
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self // Кто получает изменения
        searchController.searchBar.placeholder = Titles.search
        navigationItem.searchController = searchController // Место отображения searchController
    }
}

// MARK: - LocationTableViewControllerProtocol

extension LocationTableViewController: LocationTableViewControllerProtocol {
    
    // MARK: - Public Methods
    
    func showAlert(_ error: String) {
        failedAlert(massage: error.localizedCapitalized)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension LocationTableViewController {
    
    // MARK: - Override Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredLocations.count
        } else {
            return locations?.results.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as?
                LocationTableViewCell else {
            return UITableViewCell()
        }
        var location: Location?
        
        if isFiltering {
            location = filteredLocations[indexPath.row]
        } else {
            location = self.locations?.results[indexPath.row]
        }
        
        cell.configure(with: location)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.heightCell
    }
}
