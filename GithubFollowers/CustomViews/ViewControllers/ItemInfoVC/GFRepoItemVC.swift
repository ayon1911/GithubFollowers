//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 19.12.21.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gist, with: user.publicGists)
        actionButton.set(colour: .systemPurple, title: "Github Profile", systemImageName: "person.crop.circle.fill")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }

}
