//
//  Helper.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-28.
//

import UIKit

class Helper {
    static func getBoardgamesInformationById(for boardgames: [Boardgame]) async throws -> [Boardgame] {
        var gameIDs = [String]()
        for boardgame in boardgames {
            gameIDs.append(boardgame.gameID)
        }
        let boardgames = try await NetworkManager.shared.retrieveBoardGames(for: .game(id: gameIDs))
        return boardgames
    }
}
