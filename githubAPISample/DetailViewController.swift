
//
//  DetailViewController.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/05.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var name: String?
    var user: User?
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var followURLLabel: UILabel!
    @IBOutlet private weak var followedURLLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "詳細"
        //非同期でのデータ通信
        DispatchQueue.global().async {
            if let name = self.name {
                let router = APIRouter.user(name: name)
                let request = try! router.asURLRequest()
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if error == nil {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        self.user = try! decoder.decode(User.self, from: data!)
                        DispatchQueue.main.async { //得られたデータの描写
                            if let user = self.user {
                                self.idLabel.text = "ID: " + String(user.id)
                                self.nameLabel.text = "名前：" + user.login
                                self.followURLLabel.text = "フォロー：" + user.followingUrl
                                self.followedURLLabel.text = "フォロワー" + user.followersUrl
                            }
                        }
                    }
                }).resume()
            }
        }
    }
}
