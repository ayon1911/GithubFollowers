//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Khaled Rahman Ayon on 03.12.21.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(colour: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(colour: colour, title: title, systemImageName: systemImageName)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configuration = .tinted()
        configuration?.cornerStyle = .medium
    }
    
    final func set(colour: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = colour
        configuration?.baseForegroundColor = colour
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
}
