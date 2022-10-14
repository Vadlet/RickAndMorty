//
//  CategoryTabBarViewModel.swift
//  The Rick and Morty
//
//  Created by Vadlet on 07.10.2022.
//

import Foundation

protocol CategoryTabBarViewModelProtocol: AnyObject {
    func returnDebugMenuViewModel<T>(_ dataModel: [T]) -> DebugMenuViewModelProtocol
}

class CategoryTabBarViewModel: CategoryTabBarViewModelProtocol {
    
    func returnDebugMenuViewModel<T>(_ dataModel: [T]) -> DebugMenuViewModelProtocol {
        DebugMenuViewModel(dataModel)
    }
}
