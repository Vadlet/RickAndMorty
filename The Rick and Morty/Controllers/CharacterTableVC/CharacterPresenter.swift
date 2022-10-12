//
//  CharacterPresenter.swift
//  The Rick and Morty
//
//  Created by Vadlet on 30.08.2022.
//

import UIKit

protocol CharacterPresentingProtocol: CategoriesPresentingProtocol {
    var characters: [Character] { get }
    var filteredCharacters: [Character] { get }
}

final class CharacterPresenter: CharacterPresentingProtocol {
 
    // MARK: - Public Properties
    
    var characters: [Character] = []
    var filteredCharacters: [Character] = []
    
    weak var controller: (UITableViewController & CharacterTableViewControllerProtocol)?
    
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
        characters = storageService.fetchCharacters()
        self.controller?.reloadTable()
    }
    
    func returnDetailViewModel(indexPath: IndexPath) -> DetailViewModelProtocol {
        analyticService.sendEvent(.character, characters[indexPath.row].name ?? "No character")
        notificationService.scheduleNotifications(characters[indexPath.row].name ?? "No character")
        return CharacterDetailViewModel(character: characters[indexPath.row])
    }
    
    func updateSearch(for searchController: UISearchController) {
        filteredCharacters = searchDataManager.filterContentForSearchText(
            searchText: searchController.searchBar.text ?? "",
            dataType: characters
        )
        controller?.reloadTable()
    }
}
