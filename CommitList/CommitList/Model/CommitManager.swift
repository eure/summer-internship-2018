//
//  CommitManager.swift
//  CommitList
//
//  Created by kawaguchi kohei on 2018/05/28.
//  Copyright © 2018年 kawaguchi kohei. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CommitManager: NSObject{
    static let shared = CommitManager()
    var commits: [Commit] = []
    
    func addCommit(name: String, sha: String, message: String, email: String, url: String){
        let commit = Commit(name: name, sha: sha, message: message, email: email, url: url)
        self.commits.append(commit)
    }
    
    func fetch(){
        self.commits = []
        
        //githubにリクエスト
        Alamofire.request(Strings.targetUrl).responseJSON { response in
            // errorが発生したら終了する
            if let error = response.error{
                print(error)
                return
            }
            
            guard let value = response.result.value else {return}
            for (_, json) in JSON(value){
                if let argument = self.toArgument(by: json){
                    self.addCommit(name: argument.name, sha: argument.sha, message: argument.message, email: argument.email, url: argument.url)
                }
            }
            
        }
    }
    
    // jsonをパース
    private func toArgument(by json: JSON) -> (name: String, sha: String, message: String, email: String, url: String)?{
        guard let type = json[Strings.type].string else {return nil}
        if type != Strings.pushEvent {
            return nil
        }
        //nilを考慮して，アンラップ出来ない場合は終了する．
        guard let commitsJson = json[Strings.payload][Strings.commits].array?.first else {return nil}
        guard let message = commitsJson[Strings.message].string else {return nil}
        guard let url = commitsJson[Strings.url].string else {return nil}
        guard let sha = commitsJson[Strings.sha].string else {return nil}
        guard let name = commitsJson[Strings.author][Strings.name].string else {return nil}
        guard let email = commitsJson[Strings.author][Strings.email].string else {return nil}
        
        let result = (name: name, sha: sha, message: message, email: email, url: url)
        return result
    }
}
