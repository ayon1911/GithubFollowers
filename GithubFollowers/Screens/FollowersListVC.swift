//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 04.12.21.
//

import UIKit

class FollowersListVC: GFDataLoadingVC, UISearchControllerDelegate {
    
    enum Section { case main }
    
    var username: String!
    private var followers = [Follower]()
    private var filteredFollowers = [Follower]()
    private var page = 1
    private var hasMoreFollowers: Bool = true
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var lastScrollPosition: CGFloat = 0
    var isLoadingMoreFollowers: Bool = false
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getFollowers(username: username, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateData(on: followers)
                dismissLoadingView()
            } catch {
                presentGenericError()
                if let gfError = error as? GFError {
                    presentCustomAlertVC(title: "Bad stuff happened", message: gfError.rawValue, buttonTitle: "ok")
                } else {
                    presentGenericError()
                }
                dismissLoadingView()
            }
        }
    }
    
    @objc private func addButtonTapped() {
        showLoadingView()
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavourites(with: user)
                dismissLoadingView()
            } catch {
                if let error = error as? GFError {
                    presentCustomAlertVC(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                } else {
                    presentGenericError()
                }
                dismissLoadingView()
            }
        }
    }
    
    func addUserToFavourites(with user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favourite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.presentCustomAlertVC(title: "Success", message: "You have successfully added the user as you favorite 🤟🏽🤌🏾", buttonTitle: "Hooray 🎺")
                return
            }
            self.presentCustomAlertVC(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedFollower = dataSource.itemIdentifier(for: indexPath) else { return }
        let userInfoVC = UserInfoVC(user: selectedFollower)
        userInfoVC.delegate = self
        
        let navigationVC = UINavigationController(rootViewController: userInfoVC)
        present(navigationVC, animated: true)
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastScrollPosition = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastScrollPosition < scrollView.contentOffset.y {
            navigationItem.hidesSearchBarWhenScrolling = true
        } else if lastScrollPosition > scrollView.contentOffset.y {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offSetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}

extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: followers)
            filteredFollowers.removeAll()
            return
        }
        filteredFollowers = followers.filter({ $0.login.lowercased().contains(filter.lowercased()) })
        updateData(on: filteredFollowers)
    }
}

extension FollowersListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
