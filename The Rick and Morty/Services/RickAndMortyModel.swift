//
//  RickAndMorty.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.08.2022.
//

import Foundation

struct InfoCharacterNetwork: Decodable {
    var results: [CharacterNetwork]
}

struct InfoLocationNetwork: Decodable {
    var results: [LocationNetwork]
}

struct InfoEpisodeNetwork: Decodable {
    var results: [EpisodeNetwork]
}

struct CharacterNetwork: Decodable {
    var name: String?
    var gender: String?
    var species: String?
    var image: String?
}

struct LocationNetwork: Decodable {
    var name: String?
    var type: String?
    var dimension: String?
}

struct EpisodeNetwork: Decodable {
    var name: String?
    var air_date: String?
    var episode: String?
}
