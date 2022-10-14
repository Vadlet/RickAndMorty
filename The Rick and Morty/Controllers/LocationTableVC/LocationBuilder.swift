//
//  LocationBuilder.swift
//  The Rick and Morty
//
//  Created by Vadlet on 29.08.2022.
//

import UIKit

enum LocationBuilder {
    static func build(_ storageService: StorageServiceProtocol,
                      _ searchDataManager: SearchDataServiceProtocol,
                      _ analyticService: AnalyticsServiceProtocol,
                      _ notificationService: LocalScheduleNotificationsProtocol,
                      _ refreshDataService: RefreshDataServiceProtocol
    ) -> (UITableViewController & LocationTableViewControllerProtocol) {
        
        let presenter = LocationPresenter(storageService: storageService,
                                          searchDataManager: searchDataManager,
                                          analyticService: analyticService,
                                          notificationService: notificationService,
                                          refreshDataService: refreshDataService)
        let vc = LocationTableViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
