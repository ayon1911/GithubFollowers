//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 20.12.21.
//

import UIKit

extension Date {
    
//    func convertToMonthYearFormat() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM yyyy"
//        return dateFormatter.string(from: self)
//    }
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
