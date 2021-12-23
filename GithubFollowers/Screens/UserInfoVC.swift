//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 19.12.21.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    private var user: Follower
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews = [UIView]()
    weak var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
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
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.fillSuperview()
        contentView.fillSuperview()
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.constrainHeight(constant: 600)
    }
    
    fileprivate func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: user.login) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print("ALl the user info \(user)")
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentCustomAlertVC(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "OK")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        self.add(childVC: UserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVc(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI() {
        contentView.addSubviews(headerView, itemViewOne, itemViewTwo, dateLabel)
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        headerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding))
        headerView.constrainHeight(constant: 210)
        
        itemViewOne.anchor(top: headerView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        itemViewOne.constrainHeight(constant: itemHeight)
        
        itemViewTwo.anchor(top: itemViewOne.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
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

extension UserInfoVC: ItemInfoVCDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentCustomAlertVC(title: "Invalid URL", message: "User has an invalid URL", buttonTitle: "OK")
            return
        }
        presentSafariVC(with: url)
    }

    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentCustomAlertVC(title: "No Followers", message: "This user doesn't have any followers, what a shame 😞", buttonTitle: "So Sad")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismiss(animated: true, completion: nil)
    }
}


