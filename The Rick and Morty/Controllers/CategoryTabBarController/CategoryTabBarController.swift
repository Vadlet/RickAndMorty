//
//  CategoryTableViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

final class CategoryTabBarController: UITabBarController {
    
    // MARK: - Public Properties
    
    private var networkService: NetworkService
    private var searchDataManager: SearchDataManager
    
    // MARK: - Private Properties
    
    private func setupTabBar() {
        
        viewControllers = [
            CategoryTabBarController.createNavController(vc: CharacterBuilder.build(networkService,
                                                                                    searchDataManager),
                                                         itemName: Titles.characters,
                                                         itemImage: ImageSet.characters),
            
            CategoryTabBarController.createNavController(vc: LocationBuilder.build(networkService,
                                                                                   searchDataManager),
                                                         itemName: Titles.locations,
                                                         itemImage: ImageSet.locations),
            
            CategoryTabBarController.createNavController(vc: EpisodeBuilder.build(networkService,
                                                                                  searchDataManager),
                                                         itemName: Titles.episodes,
                                                         itemImage: ImageSet.episodes)
        ]
    }
    
    // MARK: - Initializers
    
    init(_ networkService: NetworkService, _ searchDataManager: SearchDataManager) {
        self.networkService = networkService
        self.searchDataManager = searchDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}
