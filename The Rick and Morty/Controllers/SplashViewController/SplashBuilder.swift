//
//  SplashViewControllerBuilder.swift
//  The Rick and Morty
//
//  Created by Vadlet on 01.09.2022.
//

import UIKit

enum SplashBuilder {
    static func build(_ networkService: NetworkServiceProtocol,
                      _ searchDataManager: SearchDataServiceProtocol,
                      _ storageService: StorageServiceProtocol,
                      _ analyticService: AnalyticsServiceProtocol,
                      _ notificationService: LocalScheduleNotificationsProtocol) -> (UIViewController) {
        let presenter = SplashPresenter(networkService,
                                        searchDataManager, storageService, analyticService, notificationService)
        let vc = SplashViewController(presenter)
        presenter.splashController = vc
        return vc
    }
}
