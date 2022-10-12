//
//  RickAndMorty.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.08.2022.
//

import Foundation

protocol Searchbl {
    var name: String? { get set }
}

struct InfoCharacter {
    var results: [Character]
}

struct InfoLocation {
    var results: [Location]
}

struct InfoEpisode {
    var results: [Episode]
}

struct Character: Searchbl {
    var name: String?
    var gender: String?
    var species: String?
    var img: Data?
}

struct Location: Searchbl {
    var name: String?
    var type: String?
    var dimension: String?
}

struct Episode: Searchbl {
    var name: String?
    var air_date: String?
    var episode: String?
}
