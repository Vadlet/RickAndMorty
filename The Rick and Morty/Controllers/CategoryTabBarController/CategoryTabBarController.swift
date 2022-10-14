//
//  CategoryTableViewController.swift
//  The Rick and Morty
//
//  Created by Vadlet on 03.08.2022.
//

import UIKit

final class CategoryTabBarController: UITabBarController {
    
    // MARK: - Public Properties
    
    private let storageService: StorageServiceProtocol
    private let searchDataManager: SearchDataServiceProtocol
    private let analyticService: AnalyticsServiceProtocol
    private let notificationService: LocalScheduleNotificationsProtocol
    private let refreshDataService: RefreshDataServiceProtocol
    
    private let viewModel: CategoryTabBarViewModelProtocol
    
    // MARK: - Private Properties

    private var counter = [[0], [0], [0]]
    private func setupTabBar() {
        
        viewControllers = [
            CategoryTabBarController.createNavController(vc: CharacterBuilder.build(storageService,
                                                                                    searchDataManager,
                                                                                    analyticService,
                                                                                    notificationService, refreshDataService),
                                                         itemName: R.string.titles.characters(),
                                                         itemImage: R.string.imageSet.characters()),
            
            CategoryTabBarController.createNavController(vc: LocationBuilder.build(storageService,
                                                                                   searchDataManager,
                                                                                   analyticService,
                                                                                   notificationService, refreshDataService),
                                                         itemName: R.string.titles.locations(),
                                                         itemImage: R.string.imageSet.locations()),
            
            CategoryTabBarController.createNavController(vc: EpisodeBuilder.build(storageService,
                                                                                  searchDataManager,
                                                                                  analyticService,
                                                                                  notificationService, refreshDataService),
                                                         itemName: R.string.titles.episodes(),
                                                         itemImage: R.string.imageSet.episodes())
        ]
    }
    
    // MARK: - Initializers
    
    init(_ storageService: StorageServiceProtocol,
         _ searchDataManager: SearchDataServiceProtocol,
         _ analyticService: AnalyticsServiceProtocol,
         _ notificationService: LocalScheduleNotificationsProtocol,
         _ refreshDataService: RefreshDataServiceProtocol
    ) {
        self.storageService = storageService
        self.searchDataManager = searchDataManager
        self.analyticService = analyticService
        self.notificationService = notificationService
        self.refreshDataService = refreshDataService
        viewModel = CategoryTabBarViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.errors.initCoderHasNotBeenImplemented())
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let controller = DebugMenuController()
        
        if self.selectedIndex == 0 {
            counter[0][0] += 1
            counter[1][0] = 0
            counter[2][0] = 0
            if counter[0][0] == 8 {
                controller.viewModel = viewModel.returnDebugMenuViewModel(storageService.fetchCharacters())
                present(controller, animated: true)
                counter[0][0] = 0
            }
        } else if self.selectedIndex == 1 {
            counter[0][0] = 0
            counter[1][0] += 1
            counter[2][0] = 0
            if counter[1][0] == 8 {
                controller.viewModel = viewModel.returnDebugMenuViewModel(storageService.fetchLocations())
                present(controller, animated: true)
                counter[1][0] = 0
            }
        } else {
            counter[0][0] = 0
            counter[1][0] = 0
            counter[2][0] += 1
            if counter[2][0] == 8 {
                controller.viewModel = viewModel.returnDebugMenuViewModel(storageService.fetchEpisodes())
                present(controller, animated: true)
                counter[2][0] = 0
            }
        }
    }
}
