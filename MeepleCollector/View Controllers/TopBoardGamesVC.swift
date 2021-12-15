//
//  TopBoardGamesVC.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class TopBoardGamesVC: DataLoadingVC {
    
    let tableView = UITableView()
    var boardgames = [Boardgame]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getBoardGames()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func configureViewController() {
        title = "Top Board Games"
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BoardGameListCell.self, forCellReuseIdentifier: BoardGameListCell.reuseID)
    }
    
    func getBoardGames() {
        Task {
            do {
                showLoadingView()
                let games = try await NetworkManager.shared.retrieveBoardGames(for: .hotness)
                boardgames = try await Helper.getBoardgamesInformationById(for: games)
                var count = 1
                for boardgame in boardgames {
                    boardgame.rank = count
                    count += 1
                }
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            dismissLoadingView()
        }
    }
}

extension TopBoardGamesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardgames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoardGameListCell.reuseID, for: indexPath) as! BoardGameListCell
        let boardgame = boardgames[indexPath.row]
        cell.set(boardgame: boardgame)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = MyGameInfo()
        destVC.boardgame = boardgames[indexPath.row]
        present(destVC, animated: true)
    }
}
