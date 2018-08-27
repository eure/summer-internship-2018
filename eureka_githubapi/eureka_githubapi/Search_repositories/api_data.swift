//
//  api_data.swift
//  eureka_githubapi
//
//  Created by 村上拓麻 on 2018/07/22.
//  Copyright © 2018年 村上拓麻. All rights reserved.
//




import Foundation
import Alamofire            //ライブラリ追加
import SwiftyJSON

class API_data : UIViewController {
    
    var articles : [[String:String?]] = []                  //記事を格納する配列

    
    func api_request(keyword:String, apiResponse: @escaping (_ responseArticles: [[String:String?]]) -> ()){
        
        let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)                   //レポジトリの検索キーワードをURLにエンコードする
        
        Alamofire.request("https://api.github.com/users/\(keyword_encode!)/repos").responseJSON{ response in
            
            self.articles = []                               //初期化
            
            guard let object = response.result.value else{   //レスポンスが取得できなかった場合
                apiResponse(self.articles)
                return
            }
        
            let json = JSON(object)
            
            if json["message"].string == "Not Found" {       //検索該当なしの処理
                apiResponse(self.articles)
                return
            }
            
            
            json.forEach{(_,json) in
                let article : [String:String?] = [
                    "title" : json["name"].string,            //jsonから情報を取得
                    "language" : json["language"].string,
                    "url" : json["html_url"].string
                ]
                self.articles.append(article)
            }
            apiResponse(self.articles)                       //controllerに取得した記事情報を送る
        }
    }
    
   
}
