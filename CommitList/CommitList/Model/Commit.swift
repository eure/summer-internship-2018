//
//  Commit.swift
//  CommitList
//
//  Created by kawaguchi kohei on 2018/05/28.
//  Copyright © 2018年 kawaguchi kohei. All rights reserved.
//

import Foundation

class Commit: NSObject{
    var name: String?
    var sha: String?
    var message: String?
    var email: String?
    var url: URL?
    
    init(name: String, sha: String, message: String, email: String, url: String){
        self.name = name
        self.sha = sha
        self.message = message
        self.email = email
        self.url = URL(string: url)
        print("***Commit is created \nname:\(name)\nsha:\(sha)\nmessage:\(message)\nemail:\(email)\nemail:\(url)\n")
    }
    
}
