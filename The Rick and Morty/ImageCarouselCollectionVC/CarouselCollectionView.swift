//
//  CarouselCollectionView.swift
//  The Rick and Morty
//
//  Created by Vadlet on 27.09.2022.
//

import UIKit

class CarouselCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Private Properties
    
    private let viewModel: CarouselViewModelProtocol
    private let itemCount = 1000
    private let imageCollection = [
        UIImage(named: R.string.imageCarouselSet.oneImage()),
        UIImage(named: R.string.imageCarouselSet.twoImage()),
        UIImage(named: R.string.imageCarouselSet.threeImage()),
        UIImage(named: R.string.imageCarouselSet.fourImage()),
        UIImage(named: R.string.imageCarouselSet.fiveImage())
    ]
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = CGFloat.spacing
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 200)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(_ viewModel: CarouselViewModelProtocol = CarouselViewModel()) {
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = viewModel.itemIndexPath(itemCount)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    // MARK: - Public Methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarouselCollectionViewCell.cellID,
            for: indexPath
        ) as? CarouselCollectionViewCell else { return UICollectionViewCell() }
        
        cell.viewOne.image = imageCollection[indexPath.row % imageCollection.count]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemCount
    }
    
    // MARK: - Private Methods
  
    private func setupUI() {
        view.backgroundColor = .white
        setupCollectionView()
        setupConstraints()
    }
    
    private func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: CGFloat.zero, left: CGFloat.offset, bottom: CGFloat.zero, right: CGFloat.offset)
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.cellID)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
