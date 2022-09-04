//
//  CharacterBuilder.swift
//  The Rick and Morty
//
//  Created by Vadlet on 30.08.2022.
//

import UIKit

enum CharacterBuilder {
    static func build(_ networkService: NetworkService, _ searchDataManager: SearchDataManager) -> (UITableViewController & CharacterTableViewControllerProtocol) {
        let presenter = CharacterPresenter(networkService: networkService,
                                           searchDataManager: searchDataManager)
        let vc = CharacterTableViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
