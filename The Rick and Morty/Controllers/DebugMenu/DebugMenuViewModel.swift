//
//  CharacterDebugMenuViewModel.swift
//  The Rick and Morty
//
//  Created by Vadlet on 06.10.2022.
//

import Foundation

protocol DebugMenuViewModelProtocol: AnyObject {
    var setDebugInfoLabel: String? { get }
    func saveURLFlag(_ flag: Bool)
}

class DebugMenuViewModel<T>: DebugMenuViewModelProtocol {
    
    // MARK: - Public Properties
    
    var setDebugInfoLabel: String? {
        "Number of cells: \(String(dataModel.count))"
    }
    
    // MARK: - Private Properties
    
    private let dataModel: [T]
    
    // MARK: - Initializers
    
    init(_ dataModel: [T]) {
        self.dataModel = dataModel
    }
    
    // MARK: - Public Methods
    
    func saveURLFlag(_ flag: Bool) {
        if flag {
            UserDefaults.standard.set(NetworksServiceURL.testURL.rawValue, forKey: R.string.userDefaultsKey.networkServiceURL())
        } else {
            UserDefaults.standard.set(NetworksServiceURL.baseURL.rawValue, forKey: R.string.userDefaultsKey.networkServiceURL())
        }
    }
}
