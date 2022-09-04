//
//  EpisodePresenter.swift
//  The Rick and Morty
//
//  Created by Vadlet on 30.08.2022.
//

import UIKit
import Alamofire

protocol EpisodePresentingProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol, searchDataManager: SearchDataManagerProtocol)
    func fetchData()
    func updateSearchEpisode(for searchController: UISearchController)
}

final class EpisodePresenter: EpisodePresentingProtocol {
    
    // MARK: - Public Properties
    
    weak var controller: (UITableViewController & EpisodeTableViewControllerProtocol)?
    
    // MARK: - Private Properties
    
    private var networkService: NetworkServiceProtocol
    private var searchDataManager: SearchDataManagerProtocol
    
    // MARK: - Initializers
    
    init(networkService: NetworkServiceProtocol, searchDataManager: SearchDataManagerProtocol) {
        self.networkService = networkService
        self.searchDataManager = searchDataManager
    }
    
    func fetchData() {
        networkService.fetch(dataType: InfoEpisode.self, from: .episodes) { [weak self] results in
            switch results {
            case .success(let results):
                self?.controller?.episodes = results
                self?.controller?.reloadTable()
            case .failure(let error):
                self?.controller?.failedAlert(massage: error.localizedDescription)
            }
        }
    }
    
    func updateSearchEpisode(for searchController: UISearchController) {
        guard let episodes = controller?.episodes?.results else { return }
        
        controller?.filteredEpisodes = searchDataManager.filterContentForSearchText(
            searchText: searchController.searchBar.text ?? "",
            dataType: episodes
        )
        controller?.reloadTable()
    }
}
