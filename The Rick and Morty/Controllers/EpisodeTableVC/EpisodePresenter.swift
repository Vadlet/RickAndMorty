//
//  EpisodePresenter.swift
//  The Rick and Morty
//
//  Created by Vadlet on 30.08.2022.
//

import UIKit

protocol EpisodePresentingProtocol: CategoriesPresentingProtocol {
    var episodes: [Episode] { get set }
    var filteredEpisodes: [Episode] { get set }
}

final class EpisodePresenter: EpisodePresentingProtocol {
    
    // MARK: - Public Properties
    
    var episodes: [Episode] = []
    var filteredEpisodes: [Episode] = []
    
    weak var controller: (UITableViewController & EpisodeTableViewControllerProtocol)?
    
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
    
    func fetchData() {
        episodes = storageService.fetchEpisodes()
        self.controller?.reloadTable()
    }
    
    func returnDetailViewModel(indexPath: IndexPath) -> DetailViewModelProtocol {
        analyticService.sendEvent(.episode, episodes[indexPath.row].name ?? "No episode")
        notificationService.scheduleNotifications(episodes[indexPath.row].name ?? "No episode")
        return EpisodeDetailViewModel(episode: episodes[indexPath.row])
    }
    
    func updateSearch(for searchController: UISearchController) {
        
        filteredEpisodes = searchDataManager.filterContentForSearchText(
            searchText: searchController.searchBar.text ?? "",
            dataType: episodes
        )
        controller?.reloadTable()
    }
}
