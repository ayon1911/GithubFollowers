//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 19.12.21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    private var user: Follower
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        layoutUI()
        
        getUserInfo()
    }
    
    init(user: Follower) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        print("The selected follower is \(user.login)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func doneButton() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButton))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    fileprivate func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: user.login) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print("ALl the user info \(user)")
                DispatchQueue.main.async {
                    self.add(childVC: UserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVc(user: user), to: self.itemViewTwo)
                    self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
                }
            case .failure(let error):
                self.presentCustomAlertVC(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "OK")
            }
        }
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        view.addSubview(dateLabel)
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding))
        headerView.constrainHeight(constant: 190)
        
        itemViewOne.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        itemViewOne.constrainHeight(constant: itemHeight)
        
        itemViewTwo.anchor(top: itemViewOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        itemViewTwo.constrainHeight(constant: itemHeight)
        
        dateLabel.anchor(top: itemViewTwo.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: padding, left: 0, bottom: 0, right: 0))
        dateLabel.centerXInSuperview()
        dateLabel.constrainHeight(constant: 18)
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
