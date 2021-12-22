//
//  GFItemInfoVC.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 19.12.21.
//

import UIKit

protocol ItemInfoVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class GFItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    var user: User!
    weak var delegate: ItemInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackgroudView()
        configureStackView()
        laoutUI()
        configureActionButton()
    }
    
    init(user: User, delegate: ItemInfoVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroudView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() { }
    
    private func laoutUI() {
        view.addSubviews(stackView, actionButton)
        
        let padding: CGFloat = 20
        
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        stackView.constrainHeight(constant: 50)
        
        actionButton.anchor(top: stackView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: padding, bottom: padding, right: padding))
        actionButton.constrainHeight(constant: 46)
    }

}
