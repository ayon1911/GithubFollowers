//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 03.12.21.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isUsernameEntered: Bool { !usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureImageView()
        configureTextField()
        configureButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTextField.text = ""
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: viewLayout Configurations
    func configureImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        view.addSubview(logoImageView)
        logoImageView.constrainWidth(constant: 200)
        logoImageView.constrainHeight(constant: 200)
        logoImageView.centerXInSuperview()
        let logoImageViewTopConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, padding: .init(top: logoImageViewTopConstraintConstant, left: 0, bottom: 0, right: 0))
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.delegate = self
        
        usernameTextField.constrainHeight(constant: 50)
        usernameTextField.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 48, left: 50, bottom: 0, right: 50))
    }
    
    func configureButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(handlePushFollwersListVC), for: .touchUpInside)
        
        callToActionButton.constrainHeight(constant: 50)
        callToActionButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 50, right: 50))
    }
    
    //MARK: target actions
    @objc private func handlePushFollwersListVC() {
        guard isUsernameEntered else {
            print("No Username Entered")
            presentCustomAlertVC(title: "Empty Username", message: "Please enter a username, we need to know who you are looking for 😎", buttonTitle: "choa Caho")
            return
        }
        usernameTextField.resignFirstResponder()
        let followersVC = FollowersListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followersVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handlePushFollwersListVC()
        return true
    }
}
