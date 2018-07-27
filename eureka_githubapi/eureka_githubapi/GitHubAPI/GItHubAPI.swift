////
////  GItHubAPI.swift
////  eureka_githubapi
////
////  Created by 村上拓麻 on 2018/07/16.
////  Copyright © 2018年 村上拓麻. All rights reserved.
////
//
//
//import Foundation
//import Alamofire        //ライブラリを追加
//import SwiftyJSON
//import UIKit
//
//
//class GitHub_API: UIViewController{
//
//   var articles : [[String:String?]] = []      //記事を格納する配列を定義
//    let api_error = error.connection
//
//    
//    func apiRequest(apiResponse: @escaping (_ responseArticles: [[String: String?]]) -> ()){
//        Alamofire.request("https://api.github.com/repos/vmg/redcarpet/issues?state=closed").responseJSON{ response in
//
//            guard let object = response.result.value else{  //valueがnilだったらリターンする
//
//                GitHubViewController().showError(self.api_error.error_Descroption!)
//
//                return
//            }
//            let json = JSON(object) //アンラップして引数として渡す
//
//            json.forEach{(_,json) in
//                let article : [String:String?] = [      //記事を格納する辞書型の配列を作る
//                    "title":json["title"].string,
//                    "login":json["user"]["login"].string,
//                    "url":json["html_url"].string
//                ]
//                self.articles.append(article)           //記事を格納する配列に格納
//            }
//
//            print(response.result.value)
//            apiResponse(self.articles)
//
//        }
//    }
//
//}
//
