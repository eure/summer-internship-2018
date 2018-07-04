//
//  APIClient.swift
//  EurekaGithubAPISample
//
//  Created by Azuma on 2018/07/04.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation

class APIClient {
    
    static func fetchRepository(completion: @escaping (Items) -> Void) {
        let url: String = "https://api.github.com/search/repositories?q=language:swift&sort=stars"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if error == nil, let data = data {
                let decoder = JSONDecoder()
                do {
                    let items: Items = try decoder.decode(Items.self, from: data)
                    completion(items)
                } catch(let err) {
                    print(err)
                }
            } else {
                print(error!)
            }
        }.resume()
    }
    
    static func fetchReadMe(ownerName: String, repoName: String, completion: @escaping (Detail) -> Void) {
        let url: String = "https://api.github.com/repos/\(ownerName)/\(repoName)/contents/README.md"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if error == nil, let data = data {
                let decoder = JSONDecoder()
                do {
                    let detail: Detail = try decoder.decode(Detail.self, from: data)
                    completion(detail)
                } catch(let err) {
                    print(err)
                }
            } else {
                print(error!)
            }
            }.resume()
    }
    
}
