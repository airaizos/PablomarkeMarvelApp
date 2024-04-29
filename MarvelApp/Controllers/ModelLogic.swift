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
    private(set) var heroes: [HeroeData] = []
    
    init(persistence: Persistence = .shared, network: NetWorking = .shared) {
        self.persistence = persistence
        self.network = network
        do {
            self.favourites = try persistence.loadFavourites()
            fetchHeroes()
                
        } catch {
            self.favourites = []
        }
    }
    
    var favouritesCount: Int {
        get {
            favourites.count
        }
    }
    
    var heroesCount: Int {
        get {
            heroes.count
        }
    }
    
    func addFavourite(_ hero: HeroeData) {
        favourites.append(hero)
    }
    
    private func saveFavourites(_ heroes: [HeroeData]) {
        persistence.saveFavourites(heroes)
    }
   
    func fetchHeroes() {
        network.getAllHeroes { allHeroes in
            guard let downloadedHeroes = allHeroes.results else { return }
            self.heroes.append(contentsOf: downloadedHeroes)
            NotificationCenter.default.post(name: .heroes, object: nil)
        } failure: { error in
            print("error al descargar")
        }
    }
}
