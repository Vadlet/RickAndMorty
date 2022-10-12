//
//  CharacterDetailViewModel.swift
//  The Rick and Morty
//
//  Created by Vadlet on 15.09.2022.
//

import Foundation

final class CharacterDetailViewModel: DetailViewModelProtocol {
    
    // MARK: - Public Properties
    
    var setImage: Data? { character.img }
    var setDetailLabel: [String]? {
        var array = [String]()
        array.append(character.name ?? "")
        array.append(character.gender ?? "")
        array.append(character.species ?? "")
        return array
    }
    
    // MARK: - Private Methods
    
    private let character: Character
    
    // MARK: - Initializers
    
    init(character: Character) {
        self.character = character
    }
}
