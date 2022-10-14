//
//  EpisodeDetailViewModel.swift
//  The Rick and Morty
//
//  Created by Vadlet on 19.09.2022.
//

import Foundation

final class EpisodeDetailViewModel: DetailViewModelProtocol {
    
    // MARK: - Public Properties
    
    var setImage: Data?
    var setDetailLabel: [String]? {
        var array = [String]()
        array.append(episode.name ?? "")
        array.append(episode.episode ?? "")
        array.append(episode.air_date ?? "")
        return array
    }
    
    // MARK: - Private Properties
    
    private let episode: Episode
    
    // MARK: - Initializers
    
    init(episode: Episode) {
        self.episode = episode
    }
}
