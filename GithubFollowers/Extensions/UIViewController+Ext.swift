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
        let alertVC = GFAlertVCViewController(alertTitle: title, alertMessage: message, alertButtonTitle: buttonTitle)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        present(alertVC, animated: true)
    }
    
    func presentGenericError() {
        let alertVC = GFAlertVCViewController(alertTitle: "Something went wrong", alertMessage: "We were unable to complete your request at this point", alertButtonTitle: "OK")
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
    }
}
