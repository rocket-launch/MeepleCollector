//
//  BoardGameCell.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

protocol MCBoardGameCellDelegate: AnyObject {
    func didDoubleTapCell(for boardgame: Boardgame)
    func didSingleTapCell(for boardgame: Boardgame)
}

class BoardGameCell: UICollectionViewCell {
    
    static let reuseID = "BoardGameCell"
    let gameImageView = MCThumbnailImageView(frame: .zero)
    let gametitleLabel = MCTitleLabel(textAlignment: .center, fontSize: 16)
    
    var singleTap: UITapGestureRecognizer!
    var doubleTap: UITapGestureRecognizer!
    
    var boardgame: Boardgame!
    weak var delegate: MCBoardGameCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(boardgame: Boardgame) {
        self.boardgame = boardgame
        gametitleLabel.text = boardgame.name
        gameImageView.downloadThumbnail(for: boardgame)
    }
    
    private func configure() {
        addSubview(gameImageView)
        addSubview(gametitleLabel)
        configureGestureRecognizer()
        
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
    
    func configureGestureRecognizer() {
        singleTap = UITapGestureRecognizer(target: self, action: #selector(viewGameInformation))
        singleTap.numberOfTapsRequired = 1
        
        doubleTap = UITapGestureRecognizer(target: self, action: #selector(addGameToCollection))
        doubleTap.numberOfTapsRequired = 2
        
        singleTap.delegate = self
        contentView.addGestureRecognizer(singleTap)
        contentView.addGestureRecognizer(doubleTap)
    }
    
    @objc func addGameToCollection() {
        delegate?.didDoubleTapCell(for: boardgame)
    }
    
    @objc func viewGameInformation() {
        delegate?.didSingleTapCell(for: boardgame)
    }
}

extension BoardGameCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.singleTap && otherGestureRecognizer == self.doubleTap {
            return true
        } else {
            return false
        }
    }
}
