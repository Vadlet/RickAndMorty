//
//  LocationPresenter.swift
//  The Rick and Morty
//
//  Created by Vadlet on 29.08.2022.
//

import UIKit
import Alamofire

protocol LocationPresentingProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol, searchDataManager: SearchDataManagerProtocol)
    func fetchData()
    func updateSearchLocation(for searchController: UISearchController)
}

final class LocationPresenter: LocationPresentingProtocol {
    
    // MARK: - Public Properties
    
    weak var controller: (UITableViewController & LocationTableViewControllerProtocol)?
    
    // MARK: - Private Properties
    
    private var networkService: NetworkServiceProtocol
    private var searchDataManager: SearchDataManagerProtocol
    
    // MARK: - Initializers
    
    init(networkService: NetworkServiceProtocol, searchDataManager: SearchDataManagerProtocol) {
        self.networkService = networkService
        self.searchDataManager = searchDataManager
    }
    
    // MARK: - Public Methods
    
    func fetchData() {
        networkService.fetch(dataType: InfoLocation.self, from: .location) { [weak self] results in
            switch results {
            case .success(let results):
                self?.controller?.locations = results
                self?.controller?.reloadTable()
            case .failure(let error):
                self?.controller?.failedAlert(massage: error.localizedDescription)
            }
        }
    }
    
    func updateSearchLocation(for searchController: UISearchController) {
        guard let locations = controller?.locations?.results else { return }
        
        controller?.filteredLocations = searchDataManager.filterContentForSearchText(
            searchText: searchController.searchBar.text ?? "",
            dataType: locations
        )
        controller?.reloadTable()
    }
}
