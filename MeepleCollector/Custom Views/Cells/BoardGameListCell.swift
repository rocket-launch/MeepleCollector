//
//  BoardGameListCell.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class BoardGameListCell: UITableViewCell {

    static let reuseID = "BoardGameListCell"
    
    let cellBackgroundView = UIView()
    let roundedRectShadowView = UIView()
    let roundedRectContainerView = UIView()
    let gameRankView = MCRankBadge()
    let gameNameLabel = MCTitleLabel(textAlignment: .left, fontSize: 16)
    let gameDescriptionLabel = MCBodyLabel()
    let yearPublishedLabel = MCBodyLabel()
    let gameMiniatureImageView = MCThumbnailImageView(frame: .zero)
    
    let padding: CGFloat = 6
    let cellPadding: CGFloat = 6
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(boardgame: Boardgame) {
        DispatchQueue.main.async {
            self.gameDescriptionLabel.text = boardgame.description
            self.gameNameLabel.text = boardgame.name
            self.gameRankView.gameRankLabel.text = boardgame.rank?.description
            self.yearPublishedLabel.text = boardgame.yearPublished?.description
            self.gameMiniatureImageView.downloadThumbnail(for: boardgame)
        }
    }
    
    private func configure() {
        configureCellBackgroundView()
        configureRoundedRectShadowView()
        configureRoundedRectContainerView()
        configureGameMiniatureImageView()
        configureGameRankView()
        configureGameNameLabel()
        configureYearPublishedLabel()
        configureGameDescriptionLabel()
    }
    
    private func configureCellBackgroundView() {
        addSubview(cellBackgroundView)
        
        cellBackgroundView.backgroundColor = .secondarySystemBackground
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        cellBackgroundView.pinToParent(view: self)
    }
    
    private func configureRoundedRectShadowView() {
        cellBackgroundView.addSubview(roundedRectShadowView)
        
        roundedRectShadowView.translatesAutoresizingMaskIntoConstraints = false
        roundedRectShadowView.layer.masksToBounds = false
        roundedRectShadowView.layer.cornerRadius = 10
        
        roundedRectShadowView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.6).cgColor
        roundedRectShadowView.layer.shadowOpacity = 0.4
        roundedRectShadowView.layer.shadowOffset = CGSize.zero
        roundedRectShadowView.layer.shadowRadius = 4
        
        NSLayoutConstraint.activate([
            roundedRectShadowView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: cellPadding),
            roundedRectShadowView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: cellPadding),
            roundedRectShadowView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -cellPadding),
        roundedRectShadowView.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -cellPadding)
        ])
    }
    
    private func configureRoundedRectContainerView() {
        roundedRectShadowView.addSubview(roundedRectContainerView)
        
        roundedRectContainerView.translatesAutoresizingMaskIntoConstraints = false
        roundedRectContainerView.clipsToBounds = true
        roundedRectContainerView.layer.cornerRadius = 10
        roundedRectContainerView.backgroundColor = .systemBackground
        
        roundedRectContainerView.pinToParent(view: roundedRectShadowView)
    }
    
    private func configureGameMiniatureImageView() {
        roundedRectContainerView.addSubview(gameMiniatureImageView)
        
        gameMiniatureImageView.layer.cornerRadius = 0
        
        NSLayoutConstraint.activate([
            gameMiniatureImageView.topAnchor.constraint(equalTo: roundedRectContainerView.topAnchor),
            gameMiniatureImageView.leadingAnchor.constraint(equalTo: roundedRectContainerView.leadingAnchor),
            gameMiniatureImageView.bottomAnchor.constraint(equalTo: roundedRectContainerView.bottomAnchor),
            gameMiniatureImageView.widthAnchor.constraint(equalTo: gameMiniatureImageView.heightAnchor),
        ])
    }
    
    private func configureGameNameLabel() {
        roundedRectContainerView.addSubview(gameNameLabel)
        
        NSLayoutConstraint.activate([
            gameNameLabel.topAnchor.constraint(equalTo: roundedRectContainerView.topAnchor, constant: padding),
            gameNameLabel.leadingAnchor.constraint(equalTo: gameMiniatureImageView.trailingAnchor, constant: padding),
            gameNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: gameRankView.leadingAnchor, constant: -padding),
            gameNameLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40)
        ])
    }

    private func configureGameRankView() {
        roundedRectContainerView.addSubview(gameRankView)
        
        NSLayoutConstraint.activate([
            gameRankView.trailingAnchor.constraint(equalTo: roundedRectContainerView.trailingAnchor, constant: -padding),
            gameRankView.topAnchor.constraint(equalTo: roundedRectContainerView.topAnchor, constant: padding),
            gameRankView.heightAnchor.constraint(equalToConstant: 22),
            gameRankView.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureYearPublishedLabel() {
        roundedRectContainerView.addSubview(yearPublishedLabel)
        yearPublishedLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            yearPublishedLabel.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 2),
            yearPublishedLabel.leadingAnchor.constraint(equalTo: gameNameLabel.leadingAnchor),
            yearPublishedLabel.trailingAnchor.constraint(equalTo: roundedRectContainerView.trailingAnchor, constant: -padding),
            yearPublishedLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureGameDescriptionLabel() {
        roundedRectContainerView.addSubview(gameDescriptionLabel)
        
        NSLayoutConstraint.activate([
            gameDescriptionLabel.topAnchor.constraint(equalTo: yearPublishedLabel.bottomAnchor, constant: 5),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: yearPublishedLabel.leadingAnchor),
            gameDescriptionLabel.trailingAnchor.constraint(equalTo: gameRankView.leadingAnchor),
            gameDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: roundedRectContainerView.bottomAnchor, constant: -padding)
        ])
    }
}
