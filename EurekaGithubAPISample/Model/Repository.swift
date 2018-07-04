//
//  Repository.swift
//  EurekaGithubAPISample
//
//  Created by Azuma on 2018/07/04.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation

struct Repository {
    var name: String = ""
    var id: Int = 0
    var html: String = ""
    var description: String = ""
    var starCount: Int = 0
    var language: String = ""
    var owner = Owner(id: 0, login: "", avatarURL: "")
}

struct Owner {
    var id: Int = 0
    var login: String = ""
    var avatarURL: String = ""
}
