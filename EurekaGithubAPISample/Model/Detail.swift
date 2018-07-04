//
//  Detail.swift
//  EurekaGithubAPISample
//
//  Created by Azuma on 2018/07/05.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation

struct Detail: Decodable {
    
    var content: String = ""
    
    private enum DetailKeys: String, CodingKey {
        case content
    }
    
    init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: DetailKeys.self)
        content = try root.decode(String.self, forKey: .content)
    }
}
