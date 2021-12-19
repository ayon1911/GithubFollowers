//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 19.12.21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    private var user: Follower
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButton))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: user.login) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print("ALl the user info \(user)")
            case .failure(let error):
                self.presentCustomAlertVC(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "OK")
            }
        }
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
}
