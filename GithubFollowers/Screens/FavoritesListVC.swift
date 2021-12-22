//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 20.12.21.
//

import UIKit

class FavoritesListVC: GFDataLoadingVC {
    
    let tableView = UITableView()
    var favourites = [Follower]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorite()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.removeExcessCell()
        tableView.register(FavoriteListCell.self, forCellReuseIdentifier: FavoriteListCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
    }
    
    private func getFavorite() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favourites):
                if favourites.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "You do not have any favourites at the moment 🙊", in: self.view)
                    }
                } else {
                    self.favourites = favourites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentCustomAlertVC(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteListCell.reuseID, for: indexPath) as! FavoriteListCell
        let favorite = favourites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = favourites[indexPath.row]
        let destinationVC = FollowersListVC(username: favourite.login)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favourite: favourites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                
                self.favourites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentCustomAlertVC(title: "Oops something did not work, could not delete", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
