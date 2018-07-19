//
//  GitHub.swift
//  GitHubAPI
//
//  Created by Takuma Matsushita on 2018/07/05.
//  Copyright © 2018年 Takuma Matsushita. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider

enum GitHubAPI {
    case search(q: String, page: Int)
    case readme(fullName: String)
}

extension GitHubAPI: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .search:
            return "/search/repositories"
        case .readme(let fullName):
            return "/repos/\(fullName)/readme"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        case .readme:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .search(let q, let p):
            return .requestParameters(parameters: ["q": q, "page": p], encoding: URLEncoding.queryString)
        case .readme:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        // TODO: sample
        case .search(let q):
            return "\(q)".data(using: .utf8)!
        case .readme(let fullName):
            return "\(fullName)".data(using: .utf8)!
        }
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/vnd.github.mercy-preview+json"]
    }
}

// MARK: - Codable

struct SearchResult: Codable {
    // let total_count: Int?
    // let incomplete_results: Int
    let items: [Repository]?
}

struct Repository: Codable {
    let id: Int
    let full_name: String
    let description: String?
    let stargazers_count: Int
    let updated_at: String
    let language: String?
    let html_url: String
}

struct Readme: Codable {
    let encoding: String
    let content: String
}

struct User {
    
}
