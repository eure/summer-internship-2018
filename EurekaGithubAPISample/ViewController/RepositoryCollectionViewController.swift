//
//  RepositoryCollectionViewController.swift
//  EurekaGithubAPISample
//
//  Created by Azuma on 2018/07/04.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class RepositoryCollectionViewController: UICollectionViewController {
    
    var items: Items?
    var ownerName: String = ""
    var repoName: String = ""
    var htmlURL: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        APIClient.fetchRepository { (items) in
            self.items = items
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailViewController" {
            let vc = segue.destination as! DetailViewController
            vc.ownerName = self.ownerName
            vc.repoName = self.repoName
            vc.htmlURL = self.htmlURL
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items?.repositories.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCollectionViewCell
    
        // Configure the cell
        cell.configure(repository: (items?.repositories[indexPath.item])!)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.ownerName = items?.repositories[indexPath.item].owner.login ?? ""
        self.repoName = items?.repositories[indexPath.item].name ?? ""
        self.htmlURL = items?.repositories[indexPath.item].html ?? ""
        performSegue(withIdentifier: "toDetailViewController", sender: nil)
    }

}
