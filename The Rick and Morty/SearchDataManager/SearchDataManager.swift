//
//  SearchDataManager.swift
//  The Rick and Morty
//
//  Created by Vadlet on 23.08.2022.
//

protocol SearchDataManagerProtocol {
    func filterContentForSearchText<T: Searchbl>(searchText: String, dataType: [T]) -> [T]
}

final class SearchDataManager: SearchDataManagerProtocol {
    
    func filterContentForSearchText<T: Searchbl>(searchText: String, dataType: [T]) -> [T] {
        var filteredCharacters: [T]
        filteredCharacters = dataType.filter({ character -> Bool in
            return (character.name?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        return filteredCharacters
    }
}
