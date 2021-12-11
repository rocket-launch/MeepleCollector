//
//  PersistenceManager.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-12-03.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    
    enum Key {
        static let collection = "MeepleCollector"
    }
    
    private init() {}
    
    func saveCollection(boardgame: [Boardgame]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(boardgame)
            UserDefaults.standard.set(data, forKey: Key.collection)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieveCollection() throws -> [Boardgame] {
        let decoder = JSONDecoder()
        if let encodedData = UserDefaults.standard.data(forKey: Key.collection) {
            if let boardgameCollection = try? decoder.decode([Boardgame].self, from: encodedData) {
                return boardgameCollection
            }
        }
        throw MCError.invalidData
    }
}
