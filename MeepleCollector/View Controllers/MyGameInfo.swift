//
//  MyGameInfo.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-12-13.
//

import UIKit

class MyGameInfo: UIViewController {
    
    let gameContentView = UIView()
    
    let closeButton = UIButton()
    
    let gameImageView = MCGameImageView(frame: .zero)
    let gameTitleLabel = MCTitleLabel(textAlignment: .left, fontSize: 42)
    let gameInfoContainer = UIView()
    
    let gameDescriptionLabel = MCBodyLabel(frame: .zero)
    
    let scrollView = UIScrollView()
    
    let padding: CGFloat = 10
    
    var boardgame: Boardgame!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        configureCloseButton()
        configureGameContentView()
        configureImageView()
        configureGameInfoContainerView()
        configureGameTitleLabel()
        configureGameDescriptionLabel()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    func configureCloseButton() {
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.alpha = 0.9
        closeButton.setImage(UIImage(named: "closeLight"), for: .normal)
        closeButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        ])
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.pinToSides(of: view, sides: .all())
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func configureGameContentView() {
        scrollView.addSubview(gameContentView)
        gameContentView.pinToSides(of: scrollView, sides: .all())
        
        NSLayoutConstraint.activate([
            gameContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            gameContentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        ])
    }
    
    func configureImageView() {
        gameContentView.addSubview(gameImageView)
        gameImageView.downloadImage(for: boardgame, imageType: .image)
        gameImageView.contentMode = .scaleAspectFill
        
        gameImageView.pinToSides(of: gameContentView, sides: .top(), .leading(constant: -10), .trailing(constant: -10))
        gameImageView.heightAnchor.constraint(equalToConstant: view.bounds.height - 350).isActive = true
    }
    
    func configureGameInfoContainerView() {
        gameContentView.addSubview(gameInfoContainer)
        gameInfoContainer.pinToSides(of: gameImageView, sides: .bottom(), .leading(), .trailing())
        
        gameInfoContainer.backgroundColor = .black.withAlphaComponent(0.7)
        gameContentView.bringSubviewToFront(gameInfoContainer)
        
        NSLayoutConstraint.activate([
            gameInfoContainer.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    func configureGameTitleLabel() {
        gameContentView.addSubview(gameTitleLabel)
        gameTitleLabel.pinToSides(of: gameContentView, sides: .leading(constant: padding), .trailing(constant: padding))
        
        gameTitleLabel.text = boardgame.name
        gameTitleLabel.textColor = .white
        gameTitleLabel.numberOfLines = 3
        gameTitleLabel.lineBreakMode = .byWordWrapping
        
        gameTitleLabel.layer.shadowColor = UIColor.black.cgColor
        gameTitleLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        gameTitleLabel.layer.shadowOpacity = 1
        
        NSLayoutConstraint.activate([
            gameTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
            gameTitleLabel.bottomAnchor.constraint(equalTo: gameInfoContainer.topAnchor, constant: -padding)
        ])
    }
    
    func configureGameDescriptionLabel() {
        gameContentView.addSubview(gameDescriptionLabel)
        
        gameDescriptionLabel.numberOfLines = 0
        gameDescriptionLabel.sizeToFit()
        gameDescriptionLabel.textAlignment = .justified
        gameDescriptionLabel.text = boardgame.description
        
        gameDescriptionLabel.pinToSides(of: gameContentView, sides: .leading(constant: padding), .trailing(constant: padding))
        
        NSLayoutConstraint.activate([
            gameDescriptionLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: padding),
            gameDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: gameContentView.bottomAnchor, constant: -padding),
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension MyGameInfo: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let imageEnd = view.bounds.height - 330
        
        if offsetY > imageEnd {
            closeButton.setImage(UIImage(named: "closeDark"), for: .normal)
        } else {
            closeButton.setImage(UIImage(named: "closeLight"), for: .normal)
        }
    }
}
