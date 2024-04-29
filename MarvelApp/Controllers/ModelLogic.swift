//
//  ModelLogic.swift
//  MarvelApp
//
//  Created by Adrian Iraizos Mendoza on 26/4/24.
//

import Foundation

final class ModelLogic {
    static let shared = ModelLogic()
    
    let persistence: Persistence
    let network: NetWorking
    
    private(set) var favourites: [HeroeData]  {
        didSet {
                saveFavourites(favourites)
                NotificationCenter.default.post(name: .favourites, object: nil)
        }
    }
    
    init(persistence: Persistence = .shared, network: NetWorking = .shared) {
        self.persistence = persistence
        self.network = network
        do {
            self.favourites = try persistence.loadFavourites()
        } catch {
            self.favourites = []
        }
    }
    
    func addFavourite(_ hero: HeroeData) {
        favourites.append(hero)
    }
    
    private func saveFavourites(_ heroes: [HeroeData]) {
        persistence.saveFavourites(heroes)
    }
   
}
