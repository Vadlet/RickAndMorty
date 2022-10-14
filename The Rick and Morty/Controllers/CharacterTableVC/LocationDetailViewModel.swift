//
//  LocationDetailViewModel.swift
//  The Rick and Morty
//
//  Created by Vadlet on 19.09.2022.
//

import Foundation

final class LocationDetailViewModel: DetailViewModelProtocol {
    
    // MARK: - Public Properties

    var setImage: Data?
    var setDetailLabel: [String]? {
        var array = [String]()
        array.append(location.name ?? "")
        array.append(location.dimension ?? "")
        array.append(location.type ?? "")
        return array
    }
    
    // MARK: - Private Properties
    
    private let location: Location
    
    // MARK: - Initializers

    init(location: Location) {
        self.location = location
    }
}
