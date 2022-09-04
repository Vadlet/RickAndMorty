//
//  CharacterPresenter.swift
//  The Rick and Morty
//
//  Created by Vadlet on 30.08.2022.
//

import UIKit
import Alamofire

protocol CharacterPresentingProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol, searchDataManager: SearchDataManagerProtocol)
    func fetchData()
    func updateSearchCharacter(for searchController: UISearchController)
}

final class CharacterPresenter: CharacterPresentingProtocol {
    
    // MARK: - Public Properties
    
    weak var controller: (UITableViewController & CharacterTableViewControllerProtocol)?
    
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
        networkService.fetch(dataType: InfoCharacter.self, from: .characters, completion: { [weak self] results in
            switch results {
            case .success(let results):
                self?.controller?.characters = results
                self?.controller?.reloadTable()
            case .failure(let error):
                self?.controller?.failedAlert(massage: error.localizedDescription)
            }
        })
    }
    
    func updateSearchCharacter(for searchController: UISearchController) {
        guard let locations = controller?.characters?.results else { return }
        
        controller?.filteredCharacters = searchDataManager.filterContentForSearchText(
            searchText: searchController.searchBar.text ?? "",
            dataType: locations
        )
        controller?.reloadTable()
    }
}
