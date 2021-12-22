//
//  PersistanceManager.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 20.12.21.
//

import UIKit

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static private let defaults = UserDefaults.standard
    
    static func updateWith(favourite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favourites):
                switch actionType {
                case .add:
                    guard !favourites.contains(favourite) else {
                        completed(.alreadyInFavorite)
                        return
                    }
                    favourites.append(favourite)
                case .remove:
                    favourites.removeAll(where: { $0.login == favourite.login })
                }
                completed(saveFavorites(favourites: favourites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableToSaveToFavorite))
        }
    }
    
    static func saveFavorites(favourites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favourites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return GFError.unableToSaveToFavorite
        }
    }
}
