//
//  SecondViewController.swift
//  summer-internship-2018
//
//  Created by 松平礼史 on 2018/07/10.
//  Copyright © 2018年 松平礼史. All rights reserved.
//

import Foundation
import UIKit



class SecondViewController: UIViewController {
    
    var webview: UIWebView!
    var url_link:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // webビューの追加
        webview = UIWebView(frame : self.view.bounds)
        webview.delegate = self as? UIWebViewDelegate
        // スクロールバーを無効
        webview.scrollView.bounces = false
        self.view.addSubview(webview)
        
        // closeボタンの追加
        let backButton:UIButton = UIButton()
        backButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        backButton.setTitle("close", for: .normal)
        backButton.setTitleColor(UIColor.blue, for: .normal)
        backButton.layer.position = CGPoint(x: 40, y: 40)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        
        //ViewControllerから渡されたURLを用いてNSURLクラスのurlインスタンスを作成する
        if let url = URL(string: self.url_link){
            
            //urlインスタンスを引数にして、NSURLRequestクラスのrequestインスタンスを作成する
            let request = URLRequest(url: url)
            
            //requestインスタンスを引数にして、webViewプロパティのloadRequestメソッドを実行する
            self.webview.loadRequest(request)
        }
        
    }
    
    
    // closeボタンによりViewをdismissさせる
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
