//
//  EpisodeBuilder.swift
//  The Rick and Morty
//
//  Created by Vadlet on 30.08.2022.
//

import UIKit

enum EpisodeBuilder {
    static func build(_ networkService: NetworkService, _ searchDataManager: SearchDataManager) -> (UITableViewController & EpisodeTableViewControllerProtocol) {
        let presenter = EpisodePresenter(networkService: networkService,
                                         searchDataManager: searchDataManager)
        let vc = EpisodeTableViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
