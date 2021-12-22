//
//  FaavoritesListCell.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 20.12.21.
//

import UIKit

class FavoriteListCell: UITableViewCell {
    
    static let reuseID = "FavoriteListCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        avatarImageView.constrainHeight(constant: 60)
        avatarImageView.constrainWidth(constant: 60)
        let stackView = UIStackView(arrangedSubviews: [avatarImageView, usernameLabel, UIView()])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.alignment = .center
        addSubview(stackView)
        stackView.anchor( leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        stackView.centerYInSuperview()
    }
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self] image in
            if let self = self {
                DispatchQueue.main.async { self.avatarImageView.image = image }
            }
        }
    }
}
