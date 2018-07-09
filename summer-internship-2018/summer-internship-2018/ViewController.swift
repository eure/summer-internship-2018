//
//  ViewController.swift
//  summer-internship-2018
//
//  Created by 松平礼史 on 2018/07/10.
//  Copyright © 2018年 松平礼史. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // itemsをJSONの配列と定義
    var items: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // タイトルを設定
        title = "reima21 / Repositories"
        
        
        // tableViewを作成
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        
        // APIからデータを取得
        let listUrl = "https://api.github.com/users/reima21/repos"
        Alamofire.request(listUrl).responseJSON{ response in
            let json = JSON(response.result.value ?? 0)
            
            json.forEach{(_, data) in
                self.items.append(data)
            }
            
            tableView.reloadData()
        }
        

        
    }
    

    // tableのcellにAPIから受け取ったデータを入れる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableCell")
        cell.textLabel?.text = items[indexPath.row]["name"].string
        cell.detailTextLabel?.text = "description : \(items[indexPath.row]["description"])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //SecondViewcontrollerのurl_linkプロパティURLを格納
        let secondView:SecondViewController = SecondViewController()
        secondView.url_link = items[indexPath.row]["html_url"].string!
        
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        //遷移処理
        self.present(secondView, animated: true, completion: nil)
        
        
    }
    
    
    // cellの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
