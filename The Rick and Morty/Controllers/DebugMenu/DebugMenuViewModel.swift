//
//  CharacterDebugMenuViewModel.swift
//  The Rick and Morty
//
//  Created by Vadlet on 06.10.2022.
//

import Foundation

protocol DebugMenuViewModelProtocol: AnyObject {
    var numberOfCellsLabel: String? { get }
    var sizeCoreDataLabel: String? { get }
    var switchLabel: String? { get }
}

final class DebugMenuViewModel<T>: DebugMenuViewModelProtocol {
    
    // MARK: - Public Properties
    
    var numberOfCellsLabel: String? {
        R.string.titles.numberOfCells() + String(dataModel.count)
    }
    
    var sizeCoreDataLabel: String? {
        R.string.titles.totalDataSize()
    }
    
    var switchLabel: String? {
        R.string.titles.isOnTestAPI()
    }
    
    // MARK: - Private Properties
    
    private let dataModel: [T]
    
    // MARK: - Initializers
    
    init(_ dataModel: [T]) {
        self.dataModel = dataModel
    }
}
