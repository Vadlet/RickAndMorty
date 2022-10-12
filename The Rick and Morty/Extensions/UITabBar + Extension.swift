//
//  UITabBar + Extension.swift
//  The Rick and Morty
//
//  Created by Vadlet on 31.08.2022.
//

import UIKit

extension UITabBarController {
  static func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = itemName
        navController.tabBarItem.image = UIImage(systemName: itemImage)
        navController.navigationItem.title = itemName
        return navController
    }
}
