//
//  NetworkService.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.08.2022.
//

import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case characters = "character?page=1"
    case location = "location"
    case episodes = "episode"
}

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(dataType: T.Type, from url: Link, completion: @escaping(Result<T, AFError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private static let baseURL = "https://rickandmortyapi.com/api/"
    
    func fetch<T: Decodable>(dataType: T.Type, from url: Link, completion: @escaping(Result<T, AFError>) -> Void) {
        AF.request(NetworkService.baseURL + url.rawValue)
            .validate()
            .responseDecodable(of: dataType) { dataResponse in
                DispatchQueue.main.async {
                    completion(dataResponse.result)
                }
            }
    }
}
