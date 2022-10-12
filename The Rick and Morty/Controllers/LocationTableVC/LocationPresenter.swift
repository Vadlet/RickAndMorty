//
//  LocationPresenter.swift
//  The Rick and Morty
//
//  Created by Vadlet on 29.08.2022.
//

import UIKit

protocol LocationPresentingProtocol: CategoriesPresentingProtocol {
    var locations: [Location] { get }
    var filteredLocations: [Location] { get }
}

final class LocationPresenter: LocationPresentingProtocol {
    
    // MARK: - Public Properties
    
    var locations: [Location] = []
    var filteredLocations: [Location] = []
    
    weak var controller: (UITableViewController & LocationTableViewControllerProtocol)?
    
    // MARK: - Private Properties
    
    private let storageService: StorageServiceProtocol
    private let searchDataManager: SearchDataServiceProtocol
    private let analyticService: AnalyticsServiceProtocol
    private let notificationService: LocalScheduleNotificationsProtocol
    
    // MARK: - Initializers
    
    init(storageService: StorageServiceProtocol, searchDataManager: SearchDataServiceProtocol, analyticService: AnalyticsServiceProtocol, notificationService: LocalScheduleNotificationsProtocol) {
        self.storageService = storageService
        self.searchDataManager = searchDataManager
        self.analyticService = analyticService
        self.notificationService = notificationService
    }
    
    // MARK: - Public Methods
    
    func fetchData() {
        locations = storageService.fetchLocations()
        self.controller?.reloadTable()
    }
    
    func returnDetailViewModel(indexPath: IndexPath) -> DetailViewModelProtocol {
        analyticService.sendEvent(.location, locations[indexPath.row].name ?? "No location")
        notificationService.scheduleNotifications(locations[indexPath.row].name ?? "No location")
        return LocationDetailViewModel(location: locations[indexPath.row])
    }
    
    func updateSearch(for searchController: UISearchController) {
        filteredLocations = searchDataManager.filterContentForSearchText(
            searchText: searchController.searchBar.text ?? "",
            dataType: locations
        )
        controller?.reloadTable()
    }
}
