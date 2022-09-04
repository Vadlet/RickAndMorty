//
//  RickAndMorty.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.08.2022.
//

protocol Searchbl {
    var name: String? { get set }
}

struct InfoCharacter: Decodable {
    let results: [Character]
}

struct InfoLocation: Decodable {
    let results: [Location]
}

struct InfoEpisode: Decodable {
    let results: [Episode]
}

struct Character: Decodable, Searchbl {
    var name: String?
    let gender: String?
    let species: String?
    let image: String?
}

struct Location: Decodable, Searchbl {
    var name: String?
    let type: String?
    let dimension: String?
}

struct Episode: Decodable, Searchbl {
    var name: String?
    let air_date: String?
    let episode: String?
}
