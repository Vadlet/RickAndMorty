//
//  CarouselViewModel.swift
//  The Rick and Morty
//
//  Created by Vadlet on 28.09.2022.
//

import Foundation

protocol CarouselViewModelProtocol: AnyObject {
    func itemIndexPath(_ itemCount: Int) -> IndexPath
}

final class CarouselViewModel: CarouselViewModelProtocol {
    
    func itemIndexPath(_ itemCount: Int) -> IndexPath {
        IndexPath(row: itemCount / 2, section: 0)
    }
}
