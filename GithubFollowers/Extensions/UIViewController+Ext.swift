//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 05.12.21.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentCustomAlertVC(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVCViewController(alertTitle: title, alertMessage: message, alertButtonTitle: buttonTitle)
            self.modalTransitionStyle = .crossDissolve
            self.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
    
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
    }
}
