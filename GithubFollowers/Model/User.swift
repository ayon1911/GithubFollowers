//
//  User.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 13.12.21.
//

import Foundation

struct User: Codable {
    var login: String
    var avaterUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
