//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 15.12.21.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again ð­"
    case unableToComplete = "Unable to complete your request. Please check your internet connection ðķ"
    case invalidResponse = "Invalid response from the server, please try again ðĪŠ"
    case invalidData = "The data received from the server is invalid ðŧ"
    case invalidDecoder = "Data could not be decoded please check JSONDecoder âð"
    case unableToSaveToFavorite = "There was errro while favoriting this user, Please try again later ð"
    case alreadyInFavorite = "This user is already exist in your favorites, you must like the user so much, ðĪĢ"
}
