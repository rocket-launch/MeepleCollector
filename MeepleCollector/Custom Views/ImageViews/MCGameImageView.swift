//
//  MCThumbnailImageView.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class MCGameImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        //image = UIImage(named: "BoardgamePlaceholder.png")
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 0.1
        contentMode = .scaleAspectFill
    }
    
    func downloadImage(for boardgame: Boardgame, imageType: ImageType) {
        Task {
            if let image = try await NetworkManager.shared.downloadImage(for: boardgame, imageType: imageType) {
                self.image = image
            }
        }
    }
}
