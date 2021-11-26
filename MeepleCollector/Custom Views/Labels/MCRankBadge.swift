//
//  MCRankBadge.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class MCRankBadge: UIView {
    
    let gameRankLabel = MCRankLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(gameRankLabel)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPink.withAlphaComponent(0.8)
        layer.cornerRadius = 5
        
        let padding: CGFloat = 3
        
        NSLayoutConstraint.activate([
            gameRankLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            gameRankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            gameRankLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            gameRankLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}
