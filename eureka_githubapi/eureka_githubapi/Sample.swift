//
//  Sample.swift
//  eureka_githubapi
//
//  Created by 村上拓麻 on 2018/07/16.
//  Copyright © 2018年 村上拓麻. All rights reserved.
//

import Foundation



//
//  ArticleListViewController.swift
//  api_swiftyjson_alamofire
//
//  Created by 村上拓麻 on 2018/07/11.
//  Copyright © 2018年 村上拓麻. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SafariServices


/*
 https://qiita.com/yutat93/items/1b6dfe34fa8537cf3329#%E8%A8%98%E4%BA%8B%E3%81%AE%E3%83%87%E3%83%BC%E3%82%BF%E3%81%8B%E3%82%89%E6%AC%B2%E3%81%97%E3%81%84%E6%83%85%E5%A0%B1%E3%81%AE%E3%81%BF%E3%82%92%E5%8F%96%E5%BE%97
 */

class Sample: UIViewController,UITableViewDataSource,UITableViewDelegate,SFSafariViewControllerDelegate {
    
    //記事を入れるプロパティを定義
    var articles : [[String:String?]] = []          //キーがString、値がString?
    
    let table = UITableView()           //プロパティに    tableを追加
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "新着記事"      //navigationBarのタイトル文字設定
        table.frame = view.frame //tableの大きさをviewに合わせる
        view.addSubview(table)      //viewにtableをのせる
        
        table.delegate = self
        table.dataSource = self //datasourceプロパティに自身を代入
        
        getArticles()
    }
    
    func getArticles(){
        //requestはmethodとURLStringの二つの引数をとる
        //methodは通信の種類を表す
        //resultの型は Result<Value, Error>
        Alamofire.request("https://api.github.com/repos/vmg/redcarpet/issues?state=closed").responseJSON{ response in
            guard let object = response.result.value else{      //valueがnilだったら早期リターン
                return
            }
            let json = JSON(object) //アンラップして引数として渡す
            //forEachは引数に1つの関数をとり、複数の要素それぞれに、引数で渡した処理をしてくれる
            json.forEach{ (_,json)  in
                let article : [String:String?] = [      //一つの記事を格納する辞書型の配列を作る
                    "title" : json["title"].string,
                    "login": json["user"]["login"].string,
                    "url" : json["user"]["html_url"].string
                ]
                self.articles.append(article)       //配列に入れる
                print(json["title"].string)       //jsonから"title"がキーの物を取得
                print(json["user"]["id"].string)        //userというキーの中のidというキーの中に格納されている投稿者のユーザIDを表示
                print("resuld",response.result.value)
            }
            self.table.reloadData() //tableViewを更新
        }
        //一方的に情報を受け取るときはGET
        //こちらが何か情報を送ってそれによって返される情報が変わるときはPOST
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell") // Subtitleのあるセルを生成
        let article = articles[indexPath.row]   //行番目の記事を取得
        cell.textLabel?.text = article["title"]! //記事のタイトルをtextLabelにセット
        cell.detailTextLabel?.text = article["login"]! //投稿者のユーザーIDをdetailtextLabelにセット
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    
    
    //cellが呼び出された時のdelegateメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Hello")
        
        table.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]   //行番目の記事を取得
        let urlToLink = URL(string: article["url"]!!)
        
        let safariViewController = SFSafariViewController(url: urlToLink!)
        
        safariViewController.delegate = true as? SFSafariViewControllerDelegate
        
        present(safariViewController,animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


