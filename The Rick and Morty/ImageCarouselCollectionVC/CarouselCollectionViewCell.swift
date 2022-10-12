//
//  CarouselCollectionViewCell.swift
//  The Rick and Morty
//
//  Created by Vadlet on 27.09.2022.
//

import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let cellID = R.string.cellID.carouselCollectionViewCell()
    lazy var viewOne: UIImageView = {
        let contentView = UIImageView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.contentMode = .scaleAspectFit
        return contentView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(viewOne)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = CGFloat.cornerRadius
        clipsToBounds = true
    }
    
    // MARK: - Private Methods
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            viewOne.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewOne.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewOne.topAnchor.constraint(equalTo: topAnchor),
            viewOne.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
