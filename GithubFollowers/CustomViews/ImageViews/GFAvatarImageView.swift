//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 15.12.21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        contentMode = .scaleAspectFit
        clipsToBounds = true
        image = placeHolderImage
    }
    
    func downloadImage(from urlString: String) {
        let cachedString = NSString(string: urlString)
        if let cachedImage = NetworkManager.shared.cache.object(forKey: cachedString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            NetworkManager.shared.cache.setObject(image, forKey: cachedString)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
