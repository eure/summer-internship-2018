//
//  RepositoryCollectionViewCell.swift
//  EurekaGithubAPISample
//
//  Created by Azuma on 2018/07/04.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.ownerImageView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.brown.cgColor
    }
    
    func configure(repository: Repository) {
        self.ownerNameLabel.text = repository.owner.login
        self.repositoryNameLabel.text = repository.name
        self.starCountLabel.text = String(repository.starCount)
        let url = URL(string: repository.owner.avatarURL)!
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error == nil {
                let ownerImage = UIImage.init(data: data!)
                DispatchQueue.main.async {
                    self.ownerImageView.image = ownerImage
                }
            }
        }).resume()
    }
    
}
