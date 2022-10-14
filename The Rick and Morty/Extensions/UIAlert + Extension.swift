//
//  UIAlert + Extension.swift
//  The Rick and Morty
//
//  Created by Vadlet on 22.08.2022.
//

import UIKit

extension UIViewController {
    
    func presentInOwnWindow() {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(self, animated: true)
    }
}
