//
//  GitignoreTemplateModel.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

final class GitignoreTemplateModel {

    let apiClient: GitignoreAPIClient

    weak var delegate: GitignoreTemplateModelProtocolDelegate?

    init(apiClient: GitignoreAPIClient) {
        self.apiClient = apiClient
    }
}

// MARK: - GitignoreTemplateModelProtocol
extension GitignoreTemplateModel: GitignoreTemplateModelProtocol {

    func fetchAvailableTemplateList() {
        apiClient.fetchAvailableTemplateList { data, response, error in
            guard error == nil,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data,
                let list = try? JSONDecoder().decode([String].self, from: data)
                else {
                    self.delegate?.gitignoreTemplateModel(self, didNotFetch: .templateListFetchFailure)
                    return
            }

            self.delegate?.gitignoreTemplateModel(self, didFetch: list)
        }
    }

    func fetchTemplateSource(of name: String) {
        apiClient.fetchTemplateSource(of: name) { data, response, error in
            guard error == nil,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data,
                let template = try? JSONDecoder().decode(GitignoreTemplate.self, from: data)
                else {
                    self.delegate?.gitignoreTemplateModel(self, didNotFetch: .templateSourceFetchFailure)
                    return
            }

            self.delegate?.gitignoreTemplateModel(self, didFetch: template.source)
        }
    }
}
