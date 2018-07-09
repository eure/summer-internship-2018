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
        
        
        // tableViewを作成
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        

        
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableCell")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
    // cellの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
