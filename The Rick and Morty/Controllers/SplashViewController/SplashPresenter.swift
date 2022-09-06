//
//  SplashViewControllerPresenter.swift
//  The Rick and Morty
//
//  Created by Vadlet on 01.09.2022.
//

import UIKit
import Alamofire

protocol SplashPresenterProtocol: AnyObject {
    func presentAnimateMainIcon()
}

final class SplashPresenter: SplashPresenterProtocol {
    
    // MARK: - Public Properties
    
    weak var splashController: (UIViewController & SplashViewControllerProtocol)?
    
    weak var characterController: (UITableViewController & CharacterTableViewControllerProtocol)?
    weak var locationController: (UITableViewController & LocationTableViewControllerProtocol)?
    weak var episodeController: (UITableViewController & EpisodeTableViewControllerProtocol)?
    
    // MARK: - Private Properties
    
    private var networkService: NetworkService
    private var searchDataManager: SearchDataManager
    
    // MARK: - Initializers
    
    init(_ networkService: NetworkService, _ searchDataManager: SearchDataManager) {
        self.networkService = networkService
        self.searchDataManager = searchDataManager
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func fetchDataToControllers() {
        
        let fetchDataGroup = DispatchGroup()
        
        let queueOne = DispatchQueue.global(qos: .utility)
        let queueTwo = DispatchQueue.global(qos: .utility)
        let queueThree = DispatchQueue.global(qos: .utility)
        
        queueOne.async(group: fetchDataGroup) {
            self.networkService.fetch(dataType: InfoCharacter.self, from: .characters, completion: { [weak self] results in
                switch results {
                case .success(let results):
                    self?.characterController?.characters = results
                    self?.characterController?.reloadTable()
                case .failure(let error):
                    self?.characterController?.failedAlert(massage: error.localizedDescription)
                }
            })
            print("characters ok")
        }
        
        queueTwo.async(group: fetchDataGroup) {
            self.networkService.fetch(dataType: InfoLocation.self, from: .location, completion: { [weak self] results in
                switch results {
                case .success(let results):
                    self?.locationController?.locations = results
                    self?.locationController?.reloadTable()
                case .failure(let error):
                    self?.locationController?.failedAlert(massage: error.localizedDescription)
                }
            })
            print("location ok")
        }
        
        queueThree.async(group: fetchDataGroup) {
            self.networkService.fetch(dataType: InfoEpisode.self, from: .episodes, completion: { [weak self] results in
                switch results {
                case .success(let results):
                    self?.episodeController?.episodes = results
                    self?.episodeController?.reloadTable()
                case .failure(let error):
                    self?.episodeController?.failedAlert(massage: error.localizedDescription)
                }
            })
            print("episodes ok")
        }
        
        fetchDataGroup.notify(queue: DispatchQueue.main) {
            print("all tasks executed")
        }
    }
    
    func presentAnimateMainIcon() {
        
        let tabBarController = CategoryTabBarController(networkService, searchDataManager)
        
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
}
