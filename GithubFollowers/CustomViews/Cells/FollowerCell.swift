//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 15.12.21.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        Task { avatarImageView.image = await NetworkManager.shared.downloadImage(from: follower.avatarUrl) ?? Images.avatarPlaceholder }
    }
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        avatarImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        
        usernameLabel.anchor(top: avatarImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 8, bottom: 0, right: 8))
        usernameLabel.constrainHeight(constant: 20)
    }
}
