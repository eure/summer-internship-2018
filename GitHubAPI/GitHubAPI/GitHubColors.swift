//
//  GitHubColors.swift
//  GitHubAPI
//
//  Created by Takuma Matsushita on 2018/07/17.
//  Copyright © 2018年 Takuma Matsushita. All rights reserved.
//

import Foundation
import UIKit
import Chameleon

extension UIColor {
    var githubColors: GitHubColors? {
        let path = Bundle.main.path(forResource: "colors", ofType: "json")!
        let decoder = JSONDecoder()
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let json = try decoder.decode(GitHubColors.self, from: data)
            return json
        } catch {
            print("failed to read or decode json.", error.localizedDescription)
        }
        return nil
    }
    
    func getGitHubColors(name: String) -> UIColor? {
        guard let colorCode = self.githubColors?.colors[name]?.color else { return nil }
        return HexColor(colorCode)
    }
}

struct GitHubColors: Decodable {
    
    struct Detail: Decodable {
        var color: String?
    }

    var colors: [String:Detail] = [:]
    
    private struct CodingKeys: CodingKey {
        var intValue: Int?
        var stringValue: String
        
        init?(intValue: Int) { self.intValue = intValue; self.stringValue = "" }
        init?(stringValue: String) { self.stringValue = stringValue }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        for key in container.allKeys {
            let colorName = key.stringValue
            let colorDetail = try container.decode(Detail.self, forKey: key)
            self.colors[colorName] = colorDetail
        }
    }
}









