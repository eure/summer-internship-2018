//
//  ViewController.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/05.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var users: [User] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //非同期通信でデータの取得
        DispatchQueue.global().async {
            let router = APIRouter.users
            let request = try! router.asURLRequest()
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase //取得したデータはSnakeCaseなのでそれをCamelCaseに変換
                    let jsonData = try! decoder.decode([User].self, from: data!)
                    self.users = jsonData
                    DispatchQueue.main.async {
                        self.tableView.reloadData() //取得したデータの表示
                    }
                }
            }).resume()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = self.users[indexPath.row].login
        self.performSegue(withIdentifier: "detail", sender: sender)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let data = self.users[indexPath.row]
        cell.textLabel?.text = String(data.id)
        cell.detailTextLabel?.text = data.login
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let next: DetailViewController = segue.destination as! DetailViewController
            next.name = sender as! String
        }
    }
}

