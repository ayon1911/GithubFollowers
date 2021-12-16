//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 15.12.21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        contentMode = .scaleAspectFit
        clipsToBounds = true
        image = placeHolderImage
    }
}
