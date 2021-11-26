//
//  MCTabBarController.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import UIKit

class MCTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarButtonItems()
    }
    
    func configureTabBarButtonItems() {
        UITabBar.appearance().tintColor = .systemPink
        let hot = createTabBarItem(with: TopBoardGamesVC(), title: "The Hotness", buttonItem: UITabBarItem(title: "Hot", image: SystemImage.hotness, tag: 0))
        let search = createTabBarItem(with: MyCollectionVC(), title: "Search", buttonItem: UITabBarItem(title: "Search", image: SystemImage.search, tag: 1))
        let play = createTabBarItem(with: UIViewController(), title: "Choose Board Game", buttonItem: UITabBarItem(title: "Play", image: SystemImage.dice, tag: 2))
        let games = createTabBarItem(with: UINavigationController(rootViewController: UIViewController()), title: "My Board Games", buttonItem: UITabBarItem(title: "Games", image: SystemImage.games, tag: 3))
        viewControllers = [hot, search, play, games]
    }
    
    func createTabBarItem<T: UIViewController>(with controller: T, title: String, buttonItem: UITabBarItem) -> T {
        controller.title = title
        controller.tabBarItem = buttonItem
        return controller
    }

}
