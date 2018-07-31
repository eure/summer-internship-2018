//
//  APIClientImpl.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

final class GitignoreAPIClientImpl {

    static let shared = GitignoreAPIClientImpl()

    enum Path {
        case templateList
        case template

        var baseURL: String {
            return "https://api.github.com"
        }

        var endpoint: String {
            switch self {
            case .templateList, .template:
                return baseURL + "/gitignore/templates"
            }
        }
    }
}

// MARK: - APIClient
extension GitignoreAPIClientImpl: GitignoreAPIClient {

    func fetchAvailableTemplateList(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: Path.templateList.endpoint) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }

    func fetchTemplateSource(of name: String,
                             completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: Path.template.endpoint + "/" + name) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }
}
