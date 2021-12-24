//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 15.12.21.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    
    private init() {
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endPoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else { throw GFError.invalidUsername }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GFError.invalidResponse }
        
        do { return try decoder.decode([Follower].self, from: data) }
        catch { throw GFError.invalidData }
    }
    
    func getUserInfo(for username: String) async throws -> User {
        let endPoint = baseUrl + "\(username)"
        guard let url = URL(string: endPoint) else { throw GFError.invalidUsername }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GFError.invalidResponse }
        
        do { return try decoder.decode(User.self, from: data) }
        catch { throw GFError.invalidData }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cachedString = NSString(string: urlString)
        if let cachedImage = NetworkManager.shared.cache.object(forKey: cachedString) { return cachedImage }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            NetworkManager.shared.cache.setObject(image, forKey: cachedString)
            return image
        } catch {
            return nil
        }
    }
}
