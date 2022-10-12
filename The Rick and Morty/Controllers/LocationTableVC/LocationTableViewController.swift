//
//  LocationTableViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

protocol LocationTableViewControllerProtocol: AnyObject {
    func reloadTable()
}

final class LocationTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    private let presenter: LocationPresentingProtocol
    private let cellID = R.string.cellID.locationTableViewController()
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
        fatalError(R.string.errors.initCoderHasNotBeenImplemented())
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.fetchData()
        setupSearchController()
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        title = R.string.titles.locations()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
    }
}

// MARK: - Search Controller

extension LocationTableViewController: UISearchResultsUpdating {
    
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

// MARK: - LocationTableViewControllerProtocol

extension LocationTableViewController: LocationTableViewControllerProtocol {
    
    // MARK: - Public Methods
    
    func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension LocationTableViewController {
    
    // MARK: - Override Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return presenter.filteredLocations.count
        } else {
            return presenter.locations.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as?
                LocationTableViewCell else {
            return UITableViewCell()
        }
        var item: Location?
        
        if isFiltering {
            item = presenter.filteredLocations[indexPath.row]
        } else {
            item = presenter.locations[indexPath.row]
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
