//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 19.12.21.
//

import UIKit

enum ItemInfoType {
    case repos, gist, followers, following
}

class GFItemInfoView: UIView {

    let symbolImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        return imageView
    }()
    
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countlabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [symbolImageView, titleLabel, countlabel].forEach({ addSubview($0) })
        
        symbolImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil)
        symbolImageView.constrainWidth(constant: 20)
        symbolImageView.constrainHeight(constant: 20)
        
        titleLabel.centerYAnchorWith(view: symbolImageView)
        titleLabel.anchor(top: nil, leading: symbolImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        titleLabel.constrainHeight(constant: 18)
        
        countlabel.anchor(top: symbolImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        countlabel.constrainHeight(constant: 18)
    }
    
    func set(itemInfoType: ItemInfoType, with count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gist:
            symbolImageView.image = UIImage(systemName: SFSymbols.gist)
            titleLabel.text = "Public Gist"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        countlabel.text = String(count)
    }

}
