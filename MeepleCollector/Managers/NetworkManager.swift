//
//  NetworkManager.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import Foundation

enum RequestType {
    case hotness
    case search(keyword: String?)
    case game(id: String?)
    
    var endpoint: String {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.boardgamegeek.com"
        
        switch self {
        case .hotness:
            //https://www.boardgamegeek.com/xmlapi2/hot
            components.path = "/xmlapi2/hot"
            return components.string ?? ""
            
        case .search(let keyword):
            //https://www.boardgamegeek.com/xmlapi2/search?query=bohnanza
            components.path = "/xmlapi2/search"
            components.queryItems = [URLQueryItem(name: "query", value: keyword)]
            return components.string ?? ""
            
        case .game(let id):
            //https://www.boardgamegeek.com/xmlapi2/thing?id=11
            components.path = "/xmlapi2/thing"
            components.queryItems = [URLQueryItem(name: "id", value: id)]
            return components.string ?? ""
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func retrieveBoardGames(for type: RequestType, completion: @escaping (Result<[Boardgame], Error>) -> Void) {
        
        guard let url = URL(string: type.endpoint) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let boardgameParser = BoardGameParser(withXML: data)
            let boardgames = boardgameParser.parse()
            completion(.success(boardgames))
        })
        
        task.resume()
    }
}

