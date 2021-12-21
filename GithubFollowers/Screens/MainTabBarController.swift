//
//  MainTabBarController.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 03.12.21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarController()
    }
    
    private func setupTabBarController() {
        viewControllers = [
            createNavigationController(with: SearchVC(), title: "Search", tabBarItem: .search, tabBarItemTag: 0),
            createNavigationController(with: FavoritesListVC(), title: "Favourite", tabBarItem: .favorites, tabBarItemTag: 1)
        ]
        UITabBar.appearance().tintColor = .systemGreen
    }
    
    func createNavigationController(with rootViewController: UIViewController, title: String, tabBarItem: UITabBarItem.SystemItem, tabBarItemTag: Int) -> UINavigationController {
        rootViewController.title = title
        rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarItem, tag: tabBarItemTag)
        UINavigationBar.appearance().tintColor = .systemGreen
        
        return UINavigationController(rootViewController: rootViewController)
    }
}
