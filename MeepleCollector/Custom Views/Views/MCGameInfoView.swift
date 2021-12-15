//
//  MCGameInfoView.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-12-15.
//

import UIKit

enum GameInfoType {
    case year, time, players, age
}

class MCGameInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let infoLabel = MCTitleLabel(textAlignment: .left, fontSize: 18)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(symbolImageView, infoLabel)
        translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .white
        infoLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            symbolImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 30),
            symbolImageView.heightAnchor.constraint(equalTo: symbolImageView.widthAnchor),
            
            infoLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func set(gameInfoType: GameInfoType, withDetail detail: String) {
        switch gameInfoType {
        case .year:
            symbolImageView.image = SystemImage.yearPublished
        case .time:
            symbolImageView.image = SystemImage.playingTime
        case .players:
            symbolImageView.image = SystemImage.numberOfPlayers
        case .age:
            symbolImageView.image = SystemImage.minimumAge
        }
        infoLabel.text = detail
    }
}
