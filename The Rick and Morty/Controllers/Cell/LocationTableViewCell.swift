//
//  LocationTableViewCell.swift
//  The Rick and Morty
//
//  Created by Vadlet on 04.08.2022.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {
    
    // MARK: Private Properties
    
    private lazy var containerView = UIView.containerView()
    
    private lazy var locationLabel = UILabel(font: .avenirHeavy19())
    private lazy var typeLabel = UILabel(font: .avenirMedium13())
    private lazy var dimensionLabel = UILabel(font: .avenirMedium13())
    
    private lazy var detailLocationStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [typeLabel, dimensionLabel],
                               axis: .vertical,
                               spacing: CGFloat.smallSpacing)
        return view
    }()
    
    private lazy var locationStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [locationLabel, detailLocationStackView],
                               axis: .vertical,
                               spacing: CGFloat.spacing)
        return view
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.errors.initCoderHasNotBeenImplemented())
    }
    
    // MARK: Public Methods
    
    func configure(with location: Location?) {
        locationLabel.text = location?.name ?? "No Data"
        typeLabel.text = R.string.titles.gender(location?.type ?? "No Data")
        dimensionLabel.text = R.string.titles.species(location?.dimension ?? "No Data")
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(containerView)
        addSubview(locationStackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor,
                                               constant: CGFloat.smallOffset),
            containerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: CGFloat.offset),
            containerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: CGFloat.inset),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                  constant: CGFloat.smallInset),
            
            locationStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                       constant: CGFloat.offset),
            locationStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                        constant: CGFloat.inset),
            locationStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
