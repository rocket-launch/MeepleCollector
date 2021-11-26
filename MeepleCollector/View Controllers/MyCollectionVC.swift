//
//  MyCollectionVC.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class MyCollectionVC: UIViewController {
    
    enum Section { case main }
    
    var boardgames: [Boardgame] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Boardgame>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getBoardGames()
        configureDataSource()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UILayout.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BoardGameCell.self, forCellWithReuseIdentifier: BoardGameCell.reuseID)
    }
    
    func getBoardGames() {
        NetworkManager.shared.retrieveBoardGames(for: .hotness) { [weak self] result in
            switch result {
            case .success(let boardgames):
                self?.boardgames = boardgames
                self?.updateData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Boardgame>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardGameCell.reuseID, for: indexPath) as! BoardGameCell
            cell.set(boardgame: itemIdentifier)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Boardgame>()
        snapshot.appendSections([.main])
        snapshot.appendItems(boardgames, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

