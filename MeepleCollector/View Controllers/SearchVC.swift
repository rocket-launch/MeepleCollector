//
//  SearchVC.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class SearchVC: DataLoadingVC {
    
    var boardgames: [Boardgame] = []
    var boardgameIDs: [Boardgame] = []
    var page = 0
    
    var hasMoreResults: Bool {
        return boardgames.count < boardgameIDs.count
    }
    
    var collectionView: UICollectionView!
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
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
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func updateData() {
        collectionView.reloadData()
    }
    
    func getMoreResults() {
        guard hasMoreResults else { return }
        showLoadingView()
        Task {
            do {
                boardgames += try await Helper.getBoardgamesInformationById(for: retrieveResults(page: page, size: 45))
                updateData()
                dismissLoadingView()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func retrieveResults(page: Int, size: Int) -> [Boardgame] {
        let retrieved = boardgameIDs.dropFirst(page * size).prefix(size)
        self.page += 1
        return Array<Boardgame>(retrieved)
    }
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardgames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardGameCell.reuseID, for: indexPath) as! BoardGameCell
        cell.delegate = self
        cell.set(boardgame: boardgames[indexPath.item])
        return cell
    }
}

extension SearchVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight - height) {
            getMoreResults()
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        boardgames.removeAll()
        page = 0
        
        Task {
            do {
                boardgameIDs = try await NetworkManager.shared.retrieveBoardGames(for: .search(keyword: text))
                getMoreResults()
            } catch {
                print(error.localizedDescription)
            }
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
        var collection: [Boardgame] = []
        if let boardgames = try? PersistenceManager.shared.retrieveCollection() {
            collection = boardgames
        }
        collection.append(boardgame)
        PersistenceManager.shared.saveCollection(boardgame: collection)
        
        showAddedConfirmation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {
            self.dismissAddedConfirmation {
                self.collectionView.isUserInteractionEnabled = true
            }
        }
    }
}
