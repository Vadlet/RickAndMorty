//
//  UIButton + Extension.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

extension UIButton {
    
    convenience init(titleLabel: String, font: UIFont? = .avenirHeavy25(), image: String) {
        self.init(type: .system)
        
        self.setTitle(titleLabel, for: .normal)
        self.setImage(UIImage(named: image), for: .normal)
        self.titleLabel?.font = font
        tintColor = .black
        backgroundColor = UIColor.BackgroundButtonColor()
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
    }
}
