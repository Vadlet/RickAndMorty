//
//  EpisodeBuilder.swift
//  The Rick and Morty
//
//  Created by Vadlet on 30.08.2022.
//

import UIKit

enum EpisodeBuilder {
    static func build(_ storageService: StorageServiceProtocol, _ searchDataManager: SearchDataServiceProtocol, _ analyticService: AnalyticsServiceProtocol, _ notificationService: LocalScheduleNotificationsProtocol) -> (UITableViewController & EpisodeTableViewControllerProtocol) {
        let presenter = EpisodePresenter(storageService: storageService,
                                         searchDataManager: searchDataManager,
                                         analyticService: analyticService,
                                         notificationService: notificationService)
        let vc = EpisodeTableViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
