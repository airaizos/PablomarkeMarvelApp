//
//  Networking.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import Foundation
import Alamofire

final class NetWorking {
    
    static let shared = NetWorking()
    let statusOk = 200...299
    

    
    func getAllheroes(success: @escaping (_ allHeroes: HData) -> (),
                      failure: @escaping(_ error: Error?) -> () ) {
        let heroesUrl = URL.marvelCharacters
        
        AF.request(heroesUrl, method: .get).validate(statusCode: statusOk).responseDecodable(of: ResponseHeroe.self,
                                                                                             decoder: DataDecoder()) {
            response in
            
            if let allHeroes = response.value?.data{
                success(allHeroes)
            } else {
                failure(response.error)
            }
        }
    }
    
    func getHeroe(id: Int,
                  success: @escaping (_ heroe: [HeroeData]) -> (),
                  failure: @escaping(_ error: Error?) -> () ){
       
        let heroUrl = URL.marvelCharacter(id: id)
        AF.request(heroUrl,
                   method: .get).validate(statusCode: statusOk).responseDecodable (of: ResponseHeroe.self,
                                                                                   decoder: DataDecoder() ) {
                       response in
                       
                       if let heroeData = response.value?.data.results{
                           success(heroeData)
                       } else {
                           failure(response.error)
                       }
                   }
    }
}

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
}
