//
//  SplashViewControllerPresenter.swift
//  The Rick and Morty
//
//  Created by Vadlet on 01.09.2022.
//

import UIKit

protocol SplashPresenterProtocol: AnyObject {
    func fetchDataToControllers()
}

final class SplashPresenter: SplashPresenterProtocol {
    
    // MARK: - Public Properties
    
    weak var splashController: (UIViewController & SplashViewControllerProtocol)?
    
    // MARK: - Private Properties
    
    private let searchDataManager: SearchDataServiceProtocol
    private let storageService: StorageServiceProtocol
    private let analyticService: AnalyticsServiceProtocol
    private let notificationService: LocalScheduleNotificationsProtocol
    private let refreshDataService: RefreshDataServiceProtocol
    
    // MARK: - Initializers
    
    init(_ searchDataManager: SearchDataServiceProtocol,
         _ storageService: StorageServiceProtocol,
         _ analyticService: AnalyticsServiceProtocol,
         _ notificationService: LocalScheduleNotificationsProtocol,
         _ refreshDataService: RefreshDataServiceProtocol
    ) {
        self.searchDataManager = searchDataManager
        self.storageService = storageService
        self.analyticService = analyticService
        self.notificationService = notificationService
        self.refreshDataService = refreshDataService
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.errors.initCoderHasNotBeenImplemented())
    }
    
    // MARK: - Public Methods
    
    func fetchDataToControllers() {
        refreshDataService.fetchData()
        presentAnimateMainIcon()
    }
    
    // MARK: - Private Methods
    
    func presentAnimateMainIcon() {
        let tabBarController = CategoryTabBarController(storageService,
                                                        searchDataManager,
                                                        analyticService,
                                                        notificationService,
                                                        refreshDataService)
        
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
    
    func failedAlert(message: String) {
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
