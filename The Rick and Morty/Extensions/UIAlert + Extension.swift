//
//  UIAlert + Extension.swift
//  The Rick and Morty
//
//  Created by Vadlet on 22.08.2022.
//

import UIKit

extension UIViewController {
    
    func failedAlert(massage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: massage,
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
