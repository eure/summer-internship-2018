//
//  activityIndicator.swift
//  eureka_githubapi
//
//  Created by 村上拓麻 on 2018/07/25.
//  Copyright © 2018年 村上拓麻. All rights reserved.
//

import Foundation
import UIKit

extension Search_ViewController{

    func showIndicator(){                                           //indectorを表示させるための処理

        judge = true                                                //ロード処理のチェック
        
        ActivityIndicator = UIActivityIndicatorView()               //Indicatorを作成

        ActivityIndicator.frame = CGRect(x:0, y:0, width:100, height:100)
        ActivityIndicator.backgroundColor = UIColor(red: 0/2555, green: 0/255, blue: 0/255, alpha: 0.7)
        ActivityIndicator.removeFromSuperview()                     //読み込み中を表すviewを消す

        ActivityIndicator.tag = 1

        ActivityIndicator.layer.cornerRadius = 8
        ActivityIndicator.center = self.view.center

        ActivityIndicator.hidesWhenStopped = false                  //Indicatorの状態を管理
        ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white

        ActivityIndicator.startAnimating()                          //クルクルを開始

        self.view.addSubview(ActivityIndicator)                     //Viewに追加

    }

   
    func hideIndicator(){                                           //Indicatorを止める処理
        let loadview = ActivityIndicator.viewWithTag(1)
        loadview?.removeFromSuperview()
    }
}
