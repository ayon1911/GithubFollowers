//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 15.12.21.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again 😭"
    case unableToComplete = "Unable to complete your request. Please check your internet connection 📶"
    case invalidResponse = "Invalid response from the server, please try again 🤪"
    case invalidData = "The data received from the server is invalid 👻"
    case invalidDecoder = "Data could not be decoded please check JSONDecoder ❌😎"
}
