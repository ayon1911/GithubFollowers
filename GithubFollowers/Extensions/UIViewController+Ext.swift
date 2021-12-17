//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 05.12.21.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentCustomAlertVC(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVCViewController(alertTitle: title, alertMessage: message, alertButtonTitle: buttonTitle)
            self.modalTransitionStyle = .crossDissolve
            self.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25, animations: { containerView.alpha = 0.8 })
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}
