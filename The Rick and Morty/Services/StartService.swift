//
//  StartService.swift
//  The Rick and Morty
//
//  Created by Vadlet on 31.08.2022.
//

import UIKit

final class StartService {
    
    private var window: UIWindow?
    
    init(_ window: UIWindow) {
        self.window = window
        configWindow()
    }
    
    private func configWindow() {
        let networkService = NetworkService()
        let searchDataManager = SearchDataService()
        let storageService = StorageService()
        let analyticService = AnalyticsService()
        let localNotificationService = LocalNotifications()
        let refreshDataService = RefreshDataService(networkService, storageService)
        
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(
            rootViewController: SplashBuilder.build(searchDataManager,
                                                    storageService,
                                                    analyticService,
                                                    localNotificationService,
                                                    refreshDataService)
        )
    }
}
