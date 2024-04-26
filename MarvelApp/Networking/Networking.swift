import UIKit

final class NetWorking {
    
    static let shared = NetWorking()
    let statusOk = 200...299
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getAllHeroes(success: @escaping (_ allHeroes: HData) -> (), failure: @escaping(_ error: NetworkError?) -> () ) {
        requestCodable(url: .marvelCharacters, type: ResponseHeroe.self) { json in
            RunLoop.main.perform {
                success(json.data)
            }
        } failure: { error in
            failure(error)
        }
        
    }
    
    func getHeroe(id: Int,
                  success: @escaping (_ heroe: [HeroeData]) -> (),
                  failure: @escaping(_ error: NetworkError?) -> () ){
        
        requestCodable(url: .marvelCharacter(id: id), type: ResponseHeroe.self) { json in
            RunLoop.main.perform {
                if let heroe = json.data.results {
                    success(heroe)
                } else {
                    failure(.badJson)
                }
            }
        } failure: { error in
            failure(error)
        }
    }
    
    func requestCodable<JSON: Codable>(url: URL,
                                       type: JSON.Type, success: @escaping (_ json: JSON) -> (),
                                       failure: @escaping(_ error: NetworkError?) -> () )  {
        session.dataTask(with: url) { data, response, error in
            guard error == nil else { return failure(.badResponse) }
            guard let status = response as? HTTPURLResponse, self.statusOk.contains(status.statusCode) else { return failure(.badStatus) }
            
            if let data, let items = try? JSONDecoder().decode(JSON.self, from: data) {
                success(items)
            } else {
                return failure(.badJson)
            }
            return failure(.unknown)
        }.resume()
    }
    
    func requestImage(url: URL?, success: @escaping (_ image: UIImage) -> (),
                      failure: @escaping(_ error: NetworkError?) -> () )  {
        guard let url else {return failure(.badURL) }
        
        session.dataTask(with: url) { data, response, error in
            guard error == nil else { return failure(.badResponse ) }
            guard let status = response as? HTTPURLResponse, self.statusOk.contains(status.statusCode) else { return failure(.badStatus) }
            
            if let data, let image = UIImage(data: data) {
                   return success(image)
            } else {
                return failure(.badImage)
            }
        }.resume()
        
    }
}

enum NetworkError: Error {
    case badResponse, badStatus, badJson, badImage, unknown, badURL
}
