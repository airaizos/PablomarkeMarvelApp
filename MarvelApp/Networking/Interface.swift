//
//  Interface.swift
//  MarvelApp
//
//  Created by Adrian Iraizos Mendoza on 26/4/24.
//

import Foundation


extension URLQueryItem {
    static var marvelKey: [URLQueryItem] {
        let keys = mrvl
        
        
        let ts = URLQueryItem(name: "ts", value: keys.0)
        let ak = URLQueryItem(name: "apikey", value: keys.1)
        let hs = URLQueryItem(name: "hash", value: keys.2)
        return [ts,ak,hs]
    }
    
}

extension URL {
    
    static let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public/")!
    static func marvelCharacters(offset: Int) -> URL {
        let url = baseURL.appending(path: "characters")
        
        let offset = URLQueryItem(name: "offset", value: "\(offset)")
        
        return url.appending(queryItems: [offset]).appending(queryItems: URLQueryItem.marvelKey)
    }
    
    static var marvelCharacters: URL {
        let url = baseURL.appending(path: "characters")
        return url.appending(queryItems: URLQueryItem.marvelKey)
    }
    
    static func marvelCharacter(id: Int) -> URL {
        baseURL.appending(path: "characters/\(id)").appending(queryItems: URLQueryItem.marvelKey)
    }
    
    static let favouritesPath = URL.documentsDirectory.appending(path: "favoritesId.json")
}
