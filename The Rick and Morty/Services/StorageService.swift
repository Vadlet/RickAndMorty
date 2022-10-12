//
//  StorageService.swift
//  The Rick and Morty
//
//  Created by Vadlet on 06.09.2022.
//

import CoreData

protocol StorageServiceProtocol: AnyObject {
    func saveCharacters(_ infoCharacters: InfoCharacterNetwork)
    func saveEpisodes(_ infoEpisodes: InfoEpisodeNetwork)
    func saveLocations(_ infoLocations: InfoLocationNetwork)
    func fetchCharacters() -> [Character]
    func fetchEpisodes() -> [Episode]
    func fetchLocations() -> [Location]
}

protocol StorageSaveProtocol: AnyObject {
    func saveContext()
}

final class StorageService: StorageServiceProtocol, StorageSaveProtocol {
    
    // MARK: - Private Properties
    
    private var viewContext: NSManagedObjectContext
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: R.string.titles.coreDataName())
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Initializers
    
    init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - Public Methods
    // MARK: - Save Core Data
    
    func saveCharacters(_ infoCharacters: InfoCharacterNetwork) {
        deleteAllData(R.string.titles.characters())

        for element in infoCharacters.results {
            let entity = Characters(context: viewContext)
                guard let url = URL(string: element.image ?? "") else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                entity.img = data
            
            entity.name = element.name
            entity.gender = element.gender
            entity.species = element.species
            saveContext()
        }
    }
    
    func saveEpisodes(_ infoEpisodes: InfoEpisodeNetwork) {
        deleteAllData(R.string.titles.episodes())
        
        for element in infoEpisodes.results {
            let entity = Episodes(context: viewContext)
            
            entity.name = element.name
            entity.episode = element.episode
            entity.air_date = element.air_date
            saveContext()
        }
    }
    
    func saveLocations(_ infoLocations: InfoLocationNetwork) {
        deleteAllData(R.string.titles.locations())
        
        for element in infoLocations.results {
            let entity = Locations(context: viewContext)
            
            entity.type = element.type
            entity.name = element.name
            entity.dimension = element.dimension
            saveContext()
        }
    }
    
    // MARK: - Fetch Core Data
    
    func fetchCharacters() -> [Character] {
        var arrayElements: [Character] = []
        let fetchRequest = Characters.fetchRequest()
        
        do {
            var model = Character()
            let value = try viewContext.fetch(fetchRequest)

            for element in value {
                model.name = element.name
                model.img = element.img
                model.gender = element.gender
                model.species = element.species
                arrayElements.append(model)
            }
        } catch {
            assertionFailure(error.localizedDescription)
        }
        return arrayElements
    }
    
    func fetchEpisodes() -> [Episode] {
        var arrayElements: [Episode] = []
        let fetchRequest = Episodes.fetchRequest()
        
        do {
            var model = Episode()
            let value = try viewContext.fetch(fetchRequest)
            
            for element in value {
                model.name = element.name
                model.episode = element.episode
                model.air_date = element.air_date
                arrayElements.append(model)
            }
        } catch {
            assertionFailure(error.localizedDescription)
        }
        return arrayElements
    }
    
    func fetchLocations() -> [Location] {
        var arrayElements: [Location] = []
        let fetchRequest = Locations.fetchRequest()
        
        do {
            var model = Location()
            let value = try viewContext.fetch(fetchRequest)
            
            for element in value {
                model.type = element.type
                model.name = element.name
                model.dimension = element.dimension
                arrayElements.append(model)
            }
        } catch {
            assertionFailure(error.localizedDescription)
        }
        return arrayElements
    }
        
    // MARK: - Private Methods
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private func deleteAllData(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(batchDeleteRequest)
        } catch {
            print(error)
        }
    }
}
