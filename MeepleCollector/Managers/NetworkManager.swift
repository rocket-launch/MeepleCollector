//
//  NetworkManager.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

enum RequestType {
    case hotness
    case search(keyword: String?)
    case game(id: [String]?)
    
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
            components.queryItems = [URLQueryItem(name: "query", value: keyword), URLQueryItem(name: "type", value: "boardgame")]
            return components.string ?? ""
            
        case .game(let id):
            //https://www.boardgamegeek.com/xmlapi2/thing?id=11
            components.path = "/xmlapi2/thing"
            components.queryItems = [URLQueryItem(name: "id", value: id?.joined(separator: ","))]
            return components.string ?? ""
        }
    }
}

enum MCError: String, Error {
    case invalidURL = "Invalid URL."
    case invalidResponse = "Invalid response from the server."
    case invalidData = "Invalid collection data."
}

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    func retrieveBoardGames(for type: RequestType) async throws -> [Boardgame] {
        
        guard let url = URL(string: type.endpoint) else { throw  MCError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MCError.invalidResponse
        }
        
        let boardgameParser = BoardGameParser(withXML: data)
        let boardgames = boardgameParser.parse()
        return boardgames
    }
    
    
    func downloadThumbnail(for boardgame: Boardgame) async throws -> UIImage? {
        
        guard let urlString = boardgame.thumbnailURL else { return nil }
        
        if let image = cache.object(forKey: urlString as NSString) {
            return image
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MCError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else { return nil }
        
        cache.setObject(image, forKey: urlString as NSString)
        return image
    }
}

