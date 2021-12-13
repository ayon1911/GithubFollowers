//
//  GFAlertVCViewController.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 05.12.21.
//

import UIKit

class GFAlertVCViewController: UIViewController {
    
    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle: String?
    var alertMessage: String?
    var alertButtonTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
    
    init(alertTitle: String, alertMessage: String, alertButtonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertButtonTitle = alertButtonTitle
    
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        view.addSubview(containerView)
        containerView.constrainWidth(constant: 280)
        containerView.constrainHeight(constant: 220)
        containerView.centerInSuperview()
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, messageLabel, actionButton
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        containerView.addSubview(stackView)
        stackView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        stackView.centerXInSuperview()
        actionButton.constrainHeight(constant: 40)
        
        titleLabel.text = self.alertTitle
        messageLabel.text = self.alertMessage
        actionButton.setTitle(alertButtonTitle, for: .normal)
        
    }
}
