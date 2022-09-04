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
    
    weak var controller: (UIViewController & SplashViewControllerProtocol)?
    
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
    
    func presentAnimateMainIcon() {
        
        let tabBarController = CategoryTabBarController(networkService, searchDataManager)
        
        UIView.animate(withDuration: TimeInterval.delay45, delay: TimeInterval.delay65) {
            self.controller?.splashMainIcon.transform = CGAffineTransform(
                scaleX: CGAffineTransform.scaleX,
                y: CGAffineTransform.scaleY
            )
        } completion: { Bool in
            if Bool {
                tabBarController.modalTransitionStyle = .crossDissolve
                tabBarController.modalPresentationStyle = .fullScreen
                self.controller?.present(tabBarController, animated: true)
            }
        }
    }
}
