//
//  MCThumbnailImageView.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class MCThumbnailImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 0.1
        contentMode = .scaleAspectFill
    }
    
    func downloadThumbnail(for boardgame: Boardgame) {
        Task {
            self.image = try await NetworkManager.shared.downloadThumbnail(for: boardgame)
        }
    }
}
