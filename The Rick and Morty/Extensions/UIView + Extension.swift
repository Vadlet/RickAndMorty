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
        view.backgroundColor = UIColor.BackgroundCellColor()
        view.layer.cornerRadius = 15
        return view
    }
}
