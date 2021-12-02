//
//  Boardgame.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import Foundation

class Boardgame: Hashable {
    var gameID: String!
    var name: String?
    var rank: Int?
    var thumbnailURL: String?
    var imageURL: String?
    var description: String?
    var yearPublished: Int?
    var minPlayers: Int?
    var maxPlayers: Int?
    var playingTime: Int?
    var minAge: Int?
    
    static func == (lhs: Boardgame, rhs: Boardgame) -> Bool {
        return lhs.gameID == rhs.gameID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(gameID)
    }
}
