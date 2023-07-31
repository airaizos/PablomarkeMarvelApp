//
//  Networking.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import Foundation
import Alamofire

class NetWorking {
    
    static let shared = NetWorking()
    
    let baseUrl = "https://gateway.marvel.com:443/v1/public/"
    
    func getAllheroes(success: @escaping (_ allHeroes: [HeroeData]) -> (), failure: @escaping(_ error: Error?) -> () ){
        let heroesUrl = "https://gateway.marvel.com:443/v1/public/characters?ts=thesoer&apikey=01515cae6da0a0113d6269bc211e8fdd&hash=9a702ff5d9178eec6b3475a917573c7e"
        
        AF.request(heroesUrl, method: .get).validate(statusCode: 200...299).responseDecodable(of: ResponseHeroe.self, decoder: DataDecoder()) {
            response in
            
            if let allHeroes = response.value?.data.results{
                success(allHeroes)
                print(allHeroes)
            } else {
                failure(response.error)
                print(response.error!)
            }
        }
    }
    
    func getHeroe(id: Int, success: @escaping (_ heroe: [HeroeData]) -> (), failure: @escaping(_ error: Error?) -> () ){
       let id = String(id)
        let heroeUrl = baseUrl + "characters/\(id)?ts=thesoer&apikey=01515cae6da0a0113d6269bc211e8fdd&hash=9a702ff5d9178eec6b3475a917573c7e"
        
        AF.request(heroeUrl, method: .get).validate(statusCode: 200...299).responseDecodable (of: ResponseHeroe.self, decoder: DataDecoder() ) {
            response in
            
            if let heroeData = response.value?.data.results{
                success(heroeData)
                print(heroeData)
            } else {
                print(response.error!)
                failure(response.error)
            }
    
        }
    }
}


