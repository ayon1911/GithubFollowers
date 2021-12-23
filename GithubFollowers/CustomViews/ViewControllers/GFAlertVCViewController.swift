//
//  GFAlertVCViewController.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 05.12.21.
//

import UIKit

class GFAlertVCViewController: UIViewController {
    
    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(colour: .systemPink, title: "OK", systemImageName: "checkmark.seal.fill")
    
    var alertTitle: String?
    var alertMessage: String?
    var alertButtonTitle: String?
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, messageLabel, actionButton
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    init(alertTitle: String, alertMessage: String, alertButtonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertButtonTitle = alertButtonTitle
    
        configureView()
        setupViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func actionButtonTapped() {
        dismiss(animated: true)
    }
    
    func configureView() {
        view.addSubviews(containerView, stackView)
        
        containerView.constrainWidth(constant: 280)
        containerView.constrainHeight(constant: 220)
        containerView.centerInSuperview()
        
        stackView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        stackView.centerXInSuperview()
        actionButton.constrainHeight(constant: 40)
    }
    
    private func setupViewProperties() {
        titleLabel.text = self.alertTitle
        messageLabel.text = self.alertMessage
        actionButton.setTitle(alertButtonTitle, for: .normal)
    }
}
