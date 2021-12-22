//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 22.12.21.
//

import UIKit

extension UITableView {
    
    func removeExcessCell() {
        tableFooterView = UIView(frame: .zero)
    }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
