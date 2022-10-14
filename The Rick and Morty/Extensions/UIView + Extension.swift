//
//  UIView + Extension.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.08.2022.
//

import UIKit

extension UIView {
    
    static func containerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = R.color.backgroundCellColor()
        view.layer.cornerRadius = CGFloat.cornerRadius
        return view
    }
}
