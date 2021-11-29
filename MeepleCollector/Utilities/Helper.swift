//
//  Helper.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-28.
//

import UIKit

class Helper {
    static func getBoargamesInformation(boardgames: [Boardgame]) async throws -> [Boardgame] {
        try await withThrowingTaskGroup(of: Optional<Boardgame>.self, returning: [Boardgame].self, body: { taskGroup in
            for boardgame in boardgames {
                taskGroup.addTask {
                    if let game = try await NetworkManager.shared.retrieveBoardGames(for: .game(id: boardgame.gameID)).first {
                        
                        boardgame.name = game.name
                        boardgame.thumbnailURL = game.thumbnailURL
                        boardgame.imageURL = game.imageURL
                        boardgame.description = game.description
                        boardgame.minPlayers = game.minPlayers
                        boardgame.maxPlayers = game.maxPlayers
                        boardgame.playingTime = game.playingTime
                        boardgame.minAge = game.minAge
                        
                        return boardgame
                    }
                    return nil
                }
            }
            
            var boardgames = [Boardgame]()
            
            for try await boardgame in taskGroup {
                if let boardgame = boardgame {
                    boardgames.append(boardgame)
                }
            }
            
            return boardgames
        })
    }
}
