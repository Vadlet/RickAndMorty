//
//  SplashViewControllerPresenter.swift
//  The Rick and Morty
//
//  Created by Vadlet on 01.09.2022.
//

import UIKit
import Alamofire

protocol SplashPresenterProtocol: AnyObject {
    func fetchDataToControllers()
}

final class SplashPresenter: SplashPresenterProtocol {
    
    // MARK: - Public Properties
    
    weak var splashController: (UIViewController & SplashViewControllerProtocol)?
    
    // MARK: - Private Properties
    
    private let networkService: NetworkServiceProtocol
    private let searchDataManager: SearchDataServiceProtocol
    private let storageService: StorageServiceProtocol
    private let analyticService: AnalyticsServiceProtocol
    private let notificationService: LocalScheduleNotificationsProtocol
    
    // MARK: - Initializers
    
    init(_ networkService: NetworkServiceProtocol, _ searchDataManager: SearchDataServiceProtocol, _ storageService: StorageServiceProtocol, _ analyticService: AnalyticsServiceProtocol, _ notificationService: LocalScheduleNotificationsProtocol) {
        self.networkService = networkService
        self.searchDataManager = searchDataManager
        self.storageService = storageService
        self.analyticService = analyticService
        self.notificationService = notificationService
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.errors.initCoderHasNotBeenImplemented())
    }
    
    // MARK: - Public Methods
    
    func fetchDataToControllers() {
        
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
            self.presentAnimateMainIcon()
        }
    }
    
    // MARK: - Private Methods
    
    private func presentAnimateMainIcon() {
        let tabBarController = CategoryTabBarController(storageService, searchDataManager, analyticService, notificationService)
        
        UIView.animate(withDuration: TimeInterval.delay45, delay: TimeInterval.delay65) {
            self.splashController?.splashMainIcon.transform = CGAffineTransform(
                scaleX: CGAffineTransform.scaleX,
                y: CGAffineTransform.scaleY
            )
        } completion: { Bool in
            if Bool {
                tabBarController.modalTransitionStyle = .crossDissolve
                tabBarController.modalPresentationStyle = .fullScreen
                self.splashController?.present(tabBarController, animated: true)
            }
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
