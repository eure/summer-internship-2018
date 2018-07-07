//
//  User.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var id: Int
    var nodeId: String
    var avatarUrl: String
    var gravatarId: String
    var url: String
    var htmlUrl: String
    var followersUrl: String
    var followingUrl: String
    var gistsUrl: String
    var starredUrl: String
    var subscriptionsUrl: String
    var organizationsUrl: String
    var reposUrl: String
    var eventsUrl: String
    var receivedEventsUrl: String
    var type: String
    var siteAdmin: Bool
}
