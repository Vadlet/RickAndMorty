//
//  CategoriesPresentingProtocol.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.10.2022.
//

import UIKit

protocol CategoriesPresentingProtocol: AnyObject {
    func fetchData()
    func updateSearch(for searchController: UISearchController)
    func returnDetailViewModel(indexPath: IndexPath) -> DetailViewModelProtocol
    init(storageService: StorageServiceProtocol,
         searchDataManager: SearchDataServiceProtocol,
         analyticService: AnalyticsServiceProtocol,
         notificationService: LocalScheduleNotificationsProtocol,
         refreshDataService: RefreshDataServiceProtocol)
}
