//
//  NetworkService.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.08.2022.
//

import Alamofire
import Foundation

enum Link: String {
    case characters = "character?page=1"
    case location   = "location"
    case episodes   = "episode"
}

enum NetworksServiceURL: String {
    case baseURL = "https://rickandmortyapi.com/api/"
    case testURL = "https://rickandmortyapi.com/api/episode"
}

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(dataType: T.Type, from url: Link, completion: @escaping(Result<T, AFError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetch<T: Decodable>(dataType: T.Type, from url: Link, completion: @escaping(Result<T, AFError>) -> Void) {
        guard var debugMenuURL = UserDefaults.standard.string(forKey: R.string.userDefaultsKey.networkServiceURL()) else { return }
        if debugMenuURL == NetworksServiceURL.baseURL.rawValue {
            debugMenuURL += url.rawValue
        }
        print(debugMenuURL)
        AF.request(debugMenuURL)
            .validate()
            .responseDecodable(of: dataType) { dataResponse in
                DispatchQueue.main.async {
                    completion(dataResponse.result)
                }
            }
    }
}
