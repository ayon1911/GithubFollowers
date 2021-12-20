//
//  PersistanceManager.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 20.12.21.
//

import UIKit

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static private let defaults = UserDefaults.standard
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completed: @escaping (GFError?) -> Void) {
        retriveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrivedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorite)
                        return
                    }
                    retrivedFavorites.append(favorite)
                case .remove:
                    retrivedFavorites.removeAll(where: { $0.login == favorite.login })
                    completed(saveFavorites(favorites: favorites))
                }
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retriveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToSaveToFavorite))
        }
    }
    
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return GFError.unableToSaveToFavorite
        }
    }
}
