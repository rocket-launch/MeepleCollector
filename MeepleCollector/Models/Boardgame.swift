//
//  Boardgame.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import Foundation

class Boardgame: Hashable {
    var gameID: String?
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
    
    func getInformation(completion: @escaping () -> Void) {
        NetworkManager.shared.retrieveBoardGames(for: .game(id: self.gameID)) {[weak self] boardgames in
            guard let self = self else { return }
            
            switch boardgames {
            case .success(let boardgames):
                guard let boardgame = boardgames.first else { return }
                self.name = boardgame.name
                self.thumbnailURL = boardgame.thumbnailURL
                self.imageURL = boardgame.imageURL
                self.description = boardgame.description
                self.minPlayers = boardgame.minPlayers
                self.maxPlayers = boardgame.maxPlayers
                self.playingTime = boardgame.playingTime
                self.minAge = boardgame.minAge
                completion()
            case .failure(_):
                break
            }
        }
    }
}
