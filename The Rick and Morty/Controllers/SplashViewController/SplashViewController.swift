//
//  SplashViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 01.09.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    var splashMainIcon: UIImageView { get set }
}

final class SplashViewController: UIViewController, SplashViewControllerProtocol {
    
    // MARK: - Public Properties
    
    var splashMainIcon: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: CGFloat.withSplashIcon,
                                                  height: CGFloat.heightSplashIcon))
        imageView.image = UIImage(named: ImageSet.mainScreenIcon)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - Private Properties
    
    private let presenter: SplashPresenterProtocol
    
    // MARK: - Initializers
    
    init(_ presenter: SplashPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        splashMainIcon.center = view.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.presentAnimateMainIcon()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.addSubview(splashMainIcon)
        view.backgroundColor = .white
    }
}
