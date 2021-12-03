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
        viewControllers = [createSearchNC(), createFavouriteNC()]
        UITabBar.appearance().tintColor = .systemGreen
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavouriteNC() -> UINavigationController {
        let favouriteVC = FavouriteVC()
        favouriteVC.title = "Favourite VC"
        favouriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favouriteVC)
    }


}
