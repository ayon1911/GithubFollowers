//
//  GFUserInfoHeaderVC.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 19.12.21.
//

import UIKit

class UserInfoHeaderVC: UIViewController {
    
    lazy var avatarImageView: GFAvatarImageView = {
        let imageView = GFAvatarImageView(frame: .zero)
        imageView.constrainHeight(constant: 90)
        imageView.constrainWidth(constant: 90)
       return imageView
    }()
    
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let namelabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureUIElements()
    }
    
    func configureUIElements() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        namelabel.text = user.name ?? "No name"
        locationLabel.text = user.location ?? "No location"
        bioLabel.text = user.bio ?? "No Bio available"
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    func setupView() {
        let padding: CGFloat = 20
        
        let locationStackView = UIStackView(arrangedSubviews: [locationImageView, locationLabel])
        locationStackView.axis = .horizontal
        locationStackView.distribution = .fill
        locationStackView.alignment = .leading
        locationStackView.spacing = 6

        let userDetailsStackView = UIStackView(arrangedSubviews: [usernameLabel, namelabel, locationStackView])
        userDetailsStackView.axis = .vertical
        userDetailsStackView.distribution = .fill
        userDetailsStackView.alignment = .leading
        userDetailsStackView.spacing = 6
        
        let mainStackView = UIStackView(arrangedSubviews: [avatarImageView, userDetailsStackView])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.alignment = .leading
        mainStackView.spacing = 12
        
        view.addSubview(mainStackView)
        mainStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        
        view.addSubview(bioLabel)
        bioLabel.anchor(top: mainStackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        bioLabel.constrainHeight(constant: 80)
    }
}

