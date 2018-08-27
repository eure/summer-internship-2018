//
//  ViewController.swift
//  MyOkashi
//
//  Created by 村上拓麻 on 2018/01/16.
//  Copyright © 2018年 村上拓麻. All rights reserved.
//

import UIKit
import SafariServices

class Search_ViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,SFSafariViewControllerDelegate {
    
    let api_data = API_data()                               //apiのデータクラス
    let search_error = error.nothing_search                 //検索エラー
    let text_error = error.no_name                          //入力エラー
    var articles : [[String:String?]] = []                  //レスポンスされた記事の情報を格納する変数
    var judge : Bool = false                                //ロード処理のチェック
    var ActivityIndicator: UIActivityIndicatorView!         //読み込み処理

    
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"                                    //barのタイトル設定
        searchText.keyboardType = UIKeyboardType.alphabet   //入力次のキーボードの種類を設定
        searchText.delegate = self                          //searchBarのdelegate先の通知先を設定
        searchText.placeholder = "UserNameを入力してください"   //入力のヒントとなるプレースホルダを設定
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){           //サーチバーがクリックされた時
        view.endEditing(true)                                              //キーボードを閉じる
        articles = []                                                      //記事情報を格納する変数を初期化

        if searchBar.text != ""{                                            //入力されていたらUserNameを検索

            title = "UserName：\(searchBar.text!)"                           //barのタイトルを検索したusernameに変更
            self.showIndicator()                                            //ロード状態を表示
            api_data.api_request(keyword:searchText.text! ){ response in    //apiに検索するキーワードを送る
                self.articles = response                                    //レスポンスを変数に代入
                self.table.reloadData()
                self.hideIndicator()                                        //Indicatorを止める
                
                guard self.articles != [] else{                            //記事が取得できなかった場合
                    self.alert(self.search_error.error_Descroption!)       //alertを表示
                    self.table.reloadData()
                    return
                }
            }
        }else{
            self.alert(text_error.error_Descroption!)                      //何も入力されていなくて検索した場合のエラー表示
            
            title = "UserName：NoName"
                guard judge == false else{                                 //Activity Indicatorが表示されていた場合
                    hideIndicator()                                        //表示を停止
                    return
                }
            }
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mycell")
        var article = articles[indexPath.row]
        
        if article["language"]! == nil{                                                                 //取得した言語についての情報にnilがあった場合の処理
            article["language"]! = "なし"
        }
        
        cell.textLabel?.text = "リポジトリ名：\(String(describing: article["title"]!!))"                  //cellのテキストにリポジトリ名を表示
        cell.detailTextLabel?.text = "開発言語：\(String(describing: article["language"]!!))"            //cellのテキストに使用した開発言語を表示
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        table.deselectRow(at: indexPath, animated: true)
    
        let article = articles[indexPath.row]

        let url_link = URL(string: article["url"]!!)                                                  //リポジトリが載っているurlを取得
    
        let safariViewController = SFSafariViewController(url: url_link!)                             //safariを開く処理
        safariViewController.delegate = true as? SFSafariViewControllerDelegate
        present(safariViewController,animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)                                                      //開いたsafariを閉じる処理
    }
    
  
    
    func alert(_ error : String){                                                                    //エラー表示処理
        let ac = UIAlertController(title: "⚠️", message: error, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)                                                                  
    }
}


