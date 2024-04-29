//
//  Persistence.swift
//  MarvelApp
//
//  Created by Adrian Iraizos Mendoza on 29/4/24.
//

import Foundation


final class Persistence {
    static let shared = Persistence()
    
    func loadFavourites() throws -> [HeroeData] {
        if FileManager.default.fileExists(atPath: URL.favouritesPath.path()) {
            do {
                let data = try Data(contentsOf: .favouritesPath)
                return try JSONDecoder().decode([HeroeData].self, from: data)
            } catch {
                print("error loading favourites")
            }
        }
        return []
    }
    
    func saveFavourites(_ heroes: [HeroeData]) {
        do {
            let data = try JSONEncoder().encode(heroes)
            try data.write(to: .favouritesPath, options: .atomic)
        } catch {
            return
        }
    }
}
