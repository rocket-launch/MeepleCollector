//
//  BoardGameCell.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class BoardGameCell: UICollectionViewCell {
    
    static let reuseID = "BoardGameCell"
    let gameImageView = MCThumbnailImageView(frame: .zero)
    let gametitleLabel = MCTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(boardgame: Boardgame) {
        DispatchQueue.main.async {
            self.gametitleLabel.text = boardgame.name
            self.gameImageView.downloadThumbnail(for: boardgame)
        }
    }
    
    private func configure() {
        addSubview(gameImageView)
        addSubview(gametitleLabel)
        
        gametitleLabel.lineBreakMode = .byTruncatingTail
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: heightAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            gameImageView.heightAnchor.constraint(equalTo: gameImageView.widthAnchor),
            
            
            gametitleLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 12),
            gametitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            gametitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            gametitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
