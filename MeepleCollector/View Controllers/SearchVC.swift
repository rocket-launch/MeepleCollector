//
//  SearchVC.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class SearchVC: DataLoadingVC {
    
    enum Section { case main }
    
    var boardgames: [Boardgame] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Boardgame>!
    
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Search"
    }
    
    func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.isActive = true
        searchController.searchBar.delegate = self
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UILayout.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BoardGameCell.self, forCellWithReuseIdentifier: BoardGameCell.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Boardgame>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardGameCell.reuseID, for: indexPath) as! BoardGameCell
            cell.delegate = self
            cell.set(boardgame: itemIdentifier)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Boardgame>()
        snapshot.appendSections([.main])
        snapshot.appendItems(boardgames, toSection: .main)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        boardgames.removeAll()
        
        Task {
            do {
                showLoadingView()
                let games = try await NetworkManager.shared.retrieveBoardGames(for: .search(keyword: text))
                boardgames = try await Helper.getBoargamesInformation(boardgames: games)
                updateData()
            } catch {
                print(error.localizedDescription)
            }
            dismissLoadingView()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.isEmpty {
            boardgames.removeAll()
            updateData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        boardgames.removeAll()
        updateData()
        dismissLoadingView()
    }
}

extension SearchVC: MCBoardGameCellDelegate {
    func didSingleTapCell(for boardgame: Boardgame) {
        let destVC = GameInfoVC()
        destVC.boardgame = boardgame
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    func didDoubleTapCell(for boardgame: Boardgame) {
        collectionView.isUserInteractionEnabled = false
        showAddedConfirmation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {
            self.dismissAddedConfirmation {
                self.collectionView.isUserInteractionEnabled = true
            }
        }
    }
}
