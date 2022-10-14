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
    case prodURL = "https://rickandmortyapi.com/api/"
    case testURL = "https://rickandmortyapi.com/api/episode"
}

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(dataType: T.Type, from url: Link, completion: @escaping(Result<T, AFError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private var URL = ""
    
    func fetch<T: Decodable>(dataType: T.Type, from url: Link, completion: @escaping(Result<T, AFError>) -> Void) {
        setURL(url.rawValue)
        print(URL)
        AF.request(URL)
            .validate()
            .responseDecodable(of: dataType) { dataResponse in
                DispatchQueue.main.async {
                    completion(dataResponse.result)
                }
            }
    }
    
    private func setURL(_ link: String) {
        if UserDefaults.standard.bool(forKey: "switcher") {
            URL = NetworksServiceURL.testURL.rawValue
        } else {
            URL = NetworksServiceURL.prodURL.rawValue + link
        }
    }
}
