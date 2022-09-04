//
//  LocationBuilder.swift
//  The Rick and Morty
//
//  Created by Vadlet on 29.08.2022.
//

import UIKit

enum LocationBuilder {
    static func build(_ networkService: NetworkService, _ searchDataManager: SearchDataManager) -> (UITableViewController & LocationTableViewControllerProtocol) {
        let presenter = LocationPresenter(networkService: networkService,
                                          searchDataManager: searchDataManager)
        let vc = LocationTableViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
