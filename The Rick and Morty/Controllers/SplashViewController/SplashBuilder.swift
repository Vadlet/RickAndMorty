//
//  SplashViewControllerBuilder.swift
//  The Rick and Morty
//
//  Created by Vadlet on 01.09.2022.
//

import UIKit

enum SplashBuilder {
    static func build(_ searchDataManager: SearchDataServiceProtocol,
                      _ storageService: StorageServiceProtocol,
                      _ analyticService: AnalyticsServiceProtocol,
                      _ notificationService: LocalScheduleNotificationsProtocol,
                      _ refreshDataService: RefreshDataServiceProtocol) -> (UIViewController) {
        
        let presenter = SplashPresenter(searchDataManager,
                                        storageService,
                                        analyticService,
                                        notificationService,
                                        refreshDataService)
        let vc = SplashViewController(presenter)
        presenter.splashController = vc
        return vc
    }
}
