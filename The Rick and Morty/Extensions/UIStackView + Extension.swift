//
//  UIStackView + Extension.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
        self.distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
    }
}
