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
    let statusOk = 200...299
    
    let baseUrl = "https://gateway.marvel.com:443/v1/public/"
    
    func getAllheroes(success: @escaping (_ allHeroes: Data) -> (),
                      failure: @escaping(_ error: Error?) -> () ) {
        let heroesUrl = baseUrl + "characters?ts=thesoer&apikey=01515cae6da0a0113d6269bc211e8fdd&hash=9a702ff5d9178eec6b3475a917573c7e"
        
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
        let id = String(id)
        let heroeUrl = baseUrl + "characters/\(id)?ts=thesoer&apikey=01515cae6da0a0113d6269bc211e8fdd&hash=9a702ff5d9178eec6b3475a917573c7e"
        
        AF.request(heroeUrl,
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


