//
//  SplashViewControllerBuilder.swift
//  The Rick and Morty
//
//  Created by Vadlet on 01.09.2022.
//

import UIKit

enum SplashBuilder {
    static func build(_ networkService: NetworkService,
                      _ searchDataManager: SearchDataManager) -> (UIViewController) {
        let presenter = SplashPresenter(networkService,
                                        searchDataManager)
        let vc = SplashViewController(presenter)
        presenter.splashController = vc
        return vc
    }
}
