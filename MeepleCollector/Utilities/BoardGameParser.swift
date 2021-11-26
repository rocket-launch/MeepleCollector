//
//  BoardGameParser.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class BoardGameParser: NSObject {
    var xmlParser: XMLParser?
    var boardgame: [Boardgame] = []
    var xmlText = ""
    var currentBoardgame: Boardgame?
    
    var isThumbnailSet = false
    var isNameSet = false
    
    init(withXML data: Data) {
        xmlParser = XMLParser(data: data)
    }
    
    convenience init?(withXML xml: String) {
        guard let data = xml.data(using: .utf8) else { return nil }
        self.init(withXML: data)
    }
    
    func parse() -> [Boardgame] {
        xmlParser?.delegate = self
        xmlParser?.parse()
        return boardgame
    }
}

extension BoardGameParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        xmlText = ""
        
        if elementName == "item" {
            currentBoardgame = Boardgame()
            isThumbnailSet = false
            isNameSet = false
            
            currentBoardgame?.gameID = attributeDict["id"]
            
            guard let rank = attributeDict["rank"] else { return }
            currentBoardgame?.rank = Int(rank)
        }
        
        if elementName == "thumbnail", !isThumbnailSet, let thumbnail = attributeDict["value"] {
            currentBoardgame?.thumbnailURL = thumbnail
            isThumbnailSet = true
        }
        
        if elementName == "name", !isNameSet {
            currentBoardgame?.name = attributeDict["value"]
            isNameSet = true
        }
        
        if elementName == "yearpublished" {
            guard let yearpublished = attributeDict["value"] else { return }
            currentBoardgame?.yearPublished = Int(yearpublished)
        }
        
        if elementName == "minplayers" {
            guard let minPlayers = attributeDict["value"] else { return }
            currentBoardgame?.minPlayers = Int(minPlayers)
        }
        
        if elementName == "maxplayers" {
            guard let maxPlayers = attributeDict["value"] else { return }
            currentBoardgame?.maxPlayers = Int(maxPlayers)
        }
        
        if elementName == "playingtime" {
            guard let playingTime = attributeDict["value"] else { return }
            currentBoardgame?.playingTime = Int(playingTime)
        }
        
        if elementName == "minage" {
            guard let minAge = attributeDict["value"] else { return }
            currentBoardgame?.minAge = Int(minAge)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "thumbnail", !isThumbnailSet {
            currentBoardgame?.thumbnailURL = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
            isThumbnailSet = true
        }
        
        if elementName == "image" {
            currentBoardgame?.imageURL = xmlText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if elementName == "description" {
            currentBoardgame?.description = xmlText.trimmingCharacters(in: .whitespacesAndNewlines).htmlToString
        }
        
        if elementName == "item" {
            if let boardGame = currentBoardgame {
                boardgame.append(boardGame)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        xmlText += string
    }
}
