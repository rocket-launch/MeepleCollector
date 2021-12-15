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
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let collection = try? PersistenceManager.shared.retrieveCollection() {
            boardgames = collection
            updateData()
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "My Collection"
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UILayout.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(BoardGameCell.self, forCellWithReuseIdentifier: BoardGameCell.reuseID)
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

extension MyCollectionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = MyGameInfo()
        destVC.boardgame = boardgames[indexPath.item]
        present(destVC, animated: true)
    }
}

