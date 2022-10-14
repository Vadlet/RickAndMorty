//
//  CharacterBuilder.swift
//  The Rick and Morty
//
//  Created by Vadlet on 30.08.2022.
//

import UIKit

enum CharacterBuilder {
    static func build(_ storageService: StorageServiceProtocol,
                      _ searchDataManager: SearchDataServiceProtocol,
                      _ analyticService: AnalyticsServiceProtocol,
                      _ notificationService: LocalScheduleNotificationsProtocol,
                      _ refreshDataService: RefreshDataServiceProtocol
    ) -> (UITableViewController & CharacterTableViewControllerProtocol) {
        
        let presenter = CharacterPresenter(storageService: storageService,
                                           searchDataManager: searchDataManager,
                                           analyticService: analyticService,
                                           notificationService: notificationService,
                                           refreshDataService: refreshDataService)
        let vc = CharacterTableViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
