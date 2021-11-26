//
//  GameInfoVC.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class GameInfoVC: UIViewController {
    
    let stackView = UIStackView()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let containerOne = UIView()
    let containerTwo = UIView()
    
    let padding: CGFloat = 10
    
    let gameImageView = MCThumbnailImageView(frame: .zero)
    let gameNameLabel = MCTitleLabel(textAlignment: .left, fontSize: 25)
    let gameYearPublishedLabel = MCBodyLabel()
    let gameDescriptionLabel = MCBodyLabel()
    let gamePlayingTimeLabel = MCBodyLabel()
    let gameNumberOfPlayersLabel = MCBodyLabel()
    
    var boardgame: Boardgame!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureStackView()
        configureContainers()
        configureScrollView()
        configureUIElements()
        configureContainers()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = boardgame.name
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(gameNameLabel)
        stackView.addArrangedSubview(gameYearPublishedLabel)
        stackView.addArrangedSubview(gamePlayingTimeLabel)
        stackView.addArrangedSubview(gameNumberOfPlayersLabel)
    }
    
    func configureScrollView() {
        containerTwo.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToParent(view: containerTwo)
        contentView.pinToParent(view: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
    
    func configureContainers() {
        view.addSubviews(containerOne, containerTwo)
        containerOne.translatesAutoresizingMaskIntoConstraints = false
        containerTwo.translatesAutoresizingMaskIntoConstraints = false
        configureContainerOne()
        configureContainerTwo()
        
        NSLayoutConstraint.activate([
            containerOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerOne.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerOne.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerOne.heightAnchor.constraint(equalToConstant: 150),
            
            containerTwo.topAnchor.constraint(equalTo: containerOne.bottomAnchor, constant: padding),
            containerTwo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerTwo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerTwo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    func configureUIElements() {
        gameImageView.downloadThumbnail(for: boardgame)
        gameNameLabel.text = boardgame.name
        gameYearPublishedLabel.text = boardgame.yearPublished?.description
        gamePlayingTimeLabel.text = "Playing Time: \(boardgame.playingTime ?? 0) mins"
        gameNumberOfPlayersLabel.text = "Players: \(boardgame.minPlayers ?? 0) - \(boardgame.maxPlayers ?? 0)"
        
        gameDescriptionLabel.numberOfLines = 0
        gameDescriptionLabel.sizeToFit()
        gameDescriptionLabel.textAlignment = .justified
        gameDescriptionLabel.text = boardgame.description
    }
    
    func configureContainerOne() {
        containerOne.addSubviews(gameImageView, stackView)
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: containerOne.topAnchor, constant: padding),
            gameImageView.leadingAnchor.constraint(equalTo: containerOne.leadingAnchor, constant: padding),
            gameImageView.heightAnchor.constraint(equalToConstant: 125),
            gameImageView.widthAnchor.constraint(equalTo: gameImageView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: gameImageView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: containerOne.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: gameImageView.bottomAnchor),
        ])
    }
    
    func configureContainerTwo() {
        contentView.addSubview(gameDescriptionLabel)
        NSLayoutConstraint.activate([
            gameDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            gameDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            gameDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

