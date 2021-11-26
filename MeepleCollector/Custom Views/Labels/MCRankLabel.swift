//
//  MCRankLabel.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class MCRankLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = UIFont.systemFont(ofSize: 25, weight: .bold)
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
}
