//
//  UIImageView + Extension.swift
//  The Rick and Morty
//
//  Created by Vadlet on 15.09.2022.
//

import UIKit

extension UIImageView {
    static func characterImage() -> UIImageView {
        let image = UIImageView(image: UIImage(named: R.string.imageSet.mookPicture()))
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.layer.cornerRadius = CGFloat.cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }
}
