////
////  GitHubViewController.swift
////  eureka_githubapi
////
////  Created by 村上拓麻 on 2018/07/16.
////  Copyright © 2018年 村上拓麻. All rights reserved.
////
//
//import UIKit
//import SafariServices
//
//class GitHubViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SFSafariViewControllerDelegate{
//
//
//    let github_table = UITableView()       //tableViewを生成
//    var articles : [[String:String?]] = []       //キーがString、値がString?
//
//    var uke : String = ""
//    let api_data = GitHub_API()
//    let error_description = error.connection
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        title = "repositories"
//        api_data.apiRequest{ response in
//            print("rerere",response)
//            self.articles = response
//            self.github_table.reloadData()
//        }
//        print(api_data.articles)
//
//        print("エラー文",error_description.error_Descroption)
//
//        github_table.frame = view.frame     //tableviewの大きさをviewに合わせる
//        view.addSubview(github_table)       //viewにgithub_tableをのせる
//
//        github_table.reloadData()
//
//        github_table.delegate = self
//        github_table.dataSource = self
//
//        //        articles =  api_data.request()
//
////        showError(error_description.error_Descroption!)
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func showError(_ error: String){     //エラー表示
//        let ac = UIAlertController(title: "⚠️", message: error, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac,animated: true)
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell") // Subtitleのあるセルを生成
//        let article = articles[indexPath.row]   //行番目の記事を取得
//        cell.textLabel?.text = article["title"]! //記事のタイトルをtextLabelにセット
//        cell.detailTextLabel?.text = article["login"]! //投稿者のユーザーIDをdetailtextLabelにセット
//
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return articles.count
//    }
//
//
//
//
//    //cellが呼び出された時のdelegateメソッド
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        print(articles)
//        print("Hello")
//
//        github_table.deselectRow(at: indexPath, animated: true)
//        let article = articles[indexPath.row]   //行番目の記事を取得
//        let urlToLink = URL(string: article["url"]!!)
//
//        let safariViewController = SFSafariViewController(url: urlToLink!)
//
//        safariViewController.delegate = true as? SFSafariViewControllerDelegate
//
//        present(safariViewController,animated: true, completion: nil)
//    }
//
//    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//
//}
//
