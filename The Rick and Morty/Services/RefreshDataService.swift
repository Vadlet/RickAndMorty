//
//  RefreshDataService.swift
//  The Rick and Morty
//
//  Created by Vadlet on 13.10.2022.
//

import Foundation
import UIKit

protocol RefreshDataServiceProtocol: AnyObject {
    func fetchData()
}

final class RefreshDataService: RefreshDataServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let storageService: StorageServiceProtocol
//    private var splashPresenter: SplashPresenterProtocol
    
    init(_ networkService: NetworkServiceProtocol,
         _ storageService: StorageServiceProtocol) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    func fetchData() {
        let fetchDataGroup = DispatchGroup()
        
        let queueOne = DispatchQueue.global(qos: .utility)
        let queueTwo = DispatchQueue.global(qos: .utility)
        let queueThree = DispatchQueue.global(qos: .utility)
        
        queueOne.async(group: fetchDataGroup) {
            fetchDataGroup.enter()
            self.networkService.fetch(dataType: InfoCharacterNetwork.self, from: .characters, completion: { [weak self] results in
                switch results {
                case .success(let results):
                    self?.storageService.saveCharacters(results)
                    fetchDataGroup.leave()
                case .failure(let error):
                    fetchDataGroup.leave()
                    self?.failedAlert(message: error.localizedDescription)
                }
            })
            print("characters ok")
        }
        
        queueTwo.async(group: fetchDataGroup) {
            fetchDataGroup.enter()
            self.networkService.fetch(dataType: InfoLocationNetwork.self, from: .location, completion: { [weak self] results in
                switch results {
                case .success(let results):
                    self?.storageService.saveLocations(results)
                    fetchDataGroup.leave()
                case .failure(let error):
                    fetchDataGroup.leave()
                    self?.failedAlert(message: error.localizedDescription)
                }
            })
            print("location ok")
        }
        
        queueThree.async(group: fetchDataGroup) {
            fetchDataGroup.enter()
            self.networkService.fetch(dataType: InfoEpisodeNetwork.self, from: .episodes, completion: { [weak self] results in
                switch results {
                case .success(let results):
                    self?.storageService.saveEpisodes(results)
                    fetchDataGroup.leave()
                case .failure(let error):
                    fetchDataGroup.leave()
                    self?.failedAlert(message: error.localizedDescription)
                }
            })
            print("episodes ok")
        }
        
        fetchDataGroup.notify(queue: DispatchQueue.main) {
//            self.presentAnimateMainIcon()
        }
    }
    
    private func failedAlert(message: String) {
        let alert = UIAlertController(
            title: R.string.titles.failed(),
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: R.string.titles.ok(), style: .default)
        alert.addAction(okAction)
        alert.presentInOwnWindow()
    }
}
