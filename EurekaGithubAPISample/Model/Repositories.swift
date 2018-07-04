//
//  Repository.swift
//  EurekaGithubAPISample
//
//  Created by Azuma on 2018/07/04.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation

struct Items: Decodable {

    var totalCount: Int = 0
    var repositories: [Repository] = []
    
    private enum RootKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
    }
    
    private enum ItemsKeys: String, CodingKey {
        case name
        case id
        case html = "html_url"
        case description
        case star = "stargazers_count"
        case language
        case owner
    }
    
    private enum OwnerKeys: String, CodingKey {
        case id
        case login
        case avatar = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        self.repositories = []
        let root = try decoder.container(keyedBy: RootKeys.self)
        var items = try root.nestedUnkeyedContainer(forKey: .items)
        
        
        while !items.isAtEnd {
            let container = try items.nestedContainer(keyedBy: ItemsKeys.self)
            var item = Repository()
            item.name = try container.decode(String.self, forKey: .name)
            item.id = try container.decode(Int.self, forKey: .id)
            item.html = try container.decode(String.self, forKey: .html)
            item.description = try container.decode(String.self, forKey: .description)
            item.starCount = try container.decode(Int.self, forKey: .star)
            item.language = try container.decode(String.self, forKey: .language)
            let ownerContainer = try container.nestedContainer(keyedBy: OwnerKeys.self, forKey: .owner)
            var owner = Owner()
            owner.id = try ownerContainer.decode(Int.self, forKey: .id)
            owner.login = try ownerContainer.decode(String.self, forKey: .login)
            owner.avatarURL = try ownerContainer.decode(String.self, forKey: .avatar)
            item.owner = owner
            self.repositories.append(item)
        }
        totalCount = try root.decode(Int.self, forKey: .totalCount)
    }

}
