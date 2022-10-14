//
//  UILabel + Extension.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.08.2022.
//

import UIKit

extension UILabel {
    
    convenience init(font: UIFont? = .avenirHeavy19(), text: String? = nil) {
        self.init()
        
        self.text = text
        self.font = font
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
