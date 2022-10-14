//
//  DetailViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 15.09.2022.
//

import UIKit

protocol DetailViewModelProtocol: AnyObject {
    var setImage: Data? { get }
    var setDetailLabel: [String]? { get }
}

final class DetailViewController: UIViewController {
    
    // MARK: - Private Properties

    var viewModel: DetailViewModelProtocol! {
        didSet {
            guard let detailLabel = viewModel.setDetailLabel else { return }
            mainLabel.text = detailLabel[0]
            oneSubLabel.text = detailLabel[1]
            twoSubLabel.text = detailLabel[2]
        }
    }
    
    // MARK: - Public Properties

    private lazy var containerView = UIView.containerView()
    
    private lazy var carouselImage = CarouselCollectionView()
    private lazy var mainLabel = UILabel(font: .avenirHeavy25())
    private lazy var oneSubLabel = UILabel(font: .avenirMedium19())
    private lazy var twoSubLabel = UILabel(font: .avenirMedium19())
    
    private lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainLabel, oneSubLabel, twoSubLabel],
                                    axis: .vertical,
                                    spacing: CGFloat.smallSpacing)
        return stackView
    }()
    
    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white
        addChild(carouselImage)
        carouselImage.didMove(toParent: self)
        setupConstraints()
    }
    
    private func setupConstraints() {
        carouselImage.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        view.addSubview(carouselImage.view)
        view.addSubview(detailStackView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: carouselImage.view.bottomAnchor),
            containerView.bottomAnchor.constraint(equalTo: detailStackView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat.offset),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: CGFloat.inset),
            
            carouselImage.view.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat.offset),
            carouselImage.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carouselImage.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carouselImage.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),

            detailStackView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            detailStackView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat.offset)
        ])
    }
}
