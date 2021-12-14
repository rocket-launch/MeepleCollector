//
//  MyGameInfo.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-12-13.
//

import UIKit

class MyGameInfo: UIViewController {
    
    let gameTopContainer = UIView()
    let gameImageContainer = UIView()
    let gameInfoContainer = UIView()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let gameDescriptionLabel = MCBodyLabel(frame: .zero)
    
    let gameImageView = MCGameImageView(frame: .zero)
    let gameTitleLabel = MCTitleLabel(textAlignment: .left, fontSize: 42)
    
    let padding: CGFloat = 10
    
    var boardgame: Boardgame!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTopContainerView()
        configureImageContainerView()
        configureImageView()
        configureGameInfoContainerView()
        configureGameTitleLabel()
        configureScrollView()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    func configureTopContainerView() {
        view.addSubview(gameTopContainer)
        
        gameTopContainer.translatesAutoresizingMaskIntoConstraints = false
        gameTopContainer.clipsToBounds = true
        
        gameTopContainer.pinToSides(of: view, sides: .top(), .leading(), .trailing(), .bottom(constant: -250))
    }
    
    func configureImageContainerView() {
        gameTopContainer.addSubview(gameImageContainer)
        
        gameImageContainer.translatesAutoresizingMaskIntoConstraints = false
        gameImageContainer.clipsToBounds = true
        
        gameImageContainer.pinToSides(of: gameTopContainer, sides: .all(constant: -10))
    }
    
    func configureImageView() {
        gameImageContainer.addSubview(gameImageView)
        gameImageView.downloadImage(for: boardgame, imageType: .image)
        gameImageView.contentMode = .scaleAspectFill
        
        gameImageView.pinToSides(of: gameImageContainer, sides: .all())
    }
    
    func configureGameTitleLabel() {
        gameTopContainer.addSubview(gameTitleLabel)
        
        gameTitleLabel.text = boardgame.name
        gameTitleLabel.textColor = .white
        gameTitleLabel.numberOfLines = 3
        gameTitleLabel.lineBreakMode = .byWordWrapping
       
        
        gameTitleLabel.layer.shadowColor = UIColor.black.cgColor
        gameTitleLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        gameTitleLabel.layer.shadowOpacity = 1
        
        gameTitleLabel.pinToSides(of: gameTopContainer, sides: .leading(constant: padding), .trailing(constant: padding))

        NSLayoutConstraint.activate([
            gameTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
            gameTitleLabel.bottomAnchor.constraint(equalTo: gameInfoContainer.topAnchor, constant: -10)
        ])
    }
    
    func configureGameInfoContainerView() {
        gameTopContainer.addSubview(gameInfoContainer)
        gameInfoContainer.translatesAutoresizingMaskIntoConstraints = false
        gameInfoContainer.backgroundColor = .black.withAlphaComponent(0.7)
        gameTopContainer.bringSubviewToFront(gameInfoContainer)

        gameInfoContainer.pinToSides(of: gameImageContainer, sides: .leading(), .trailing())
        
        NSLayoutConstraint.activate([
            gameInfoContainer.bottomAnchor.constraint(equalTo: gameTopContainer.bottomAnchor),
            gameInfoContainer.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.pinToSides(of: view, sides: .leading(), .trailing())
        
        scrollView.addSubview(contentView)
        contentView.pinToSides(of: scrollView, sides: .all())
        
        contentView.addSubview(gameDescriptionLabel)
        
        gameDescriptionLabel.numberOfLines = 0
        gameDescriptionLabel.sizeToFit()
        gameDescriptionLabel.textAlignment = .justified
        gameDescriptionLabel.text = boardgame.description
        
        gameDescriptionLabel.pinToSides(of: contentView, sides: .all(constant: padding))
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: gameTopContainer.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
        ])
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
