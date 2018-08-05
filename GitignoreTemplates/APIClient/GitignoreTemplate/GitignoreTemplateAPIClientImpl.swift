//
//  APIClientImpl.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

final class GitignoreTemplateAPIClientImpl {

    static let shared = GitignoreTemplateAPIClientImpl()
    var dataTask = URLSessionTask()

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
extension GitignoreTemplateAPIClientImpl: GitignoreTemplateAPIClient {

    func fetchAvailableTemplateList(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: Path.templateList.endpoint) else { return }
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: completionHandler)
        dataTask.resume()
    }

    func fetchTemplateSource(of name: String,
                             completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: Path.template.endpoint + "/" + name) else { return }
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: completionHandler)
        dataTask.resume()
    }

    func cancelFetching() {
         dataTask.cancel()
    }
}
