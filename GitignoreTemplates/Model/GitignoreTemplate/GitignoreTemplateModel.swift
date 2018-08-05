//
//  GitignoreTemplateModel.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

final class GitignoreTemplateModel {

    let apiClient: GitignoreTemplateAPIClient

    weak var delegate: GitignoreTemplateModelDelegate?

    init(apiClient: GitignoreTemplateAPIClient) {
        self.apiClient = apiClient
    }
}

// MARK: - GitignoreTemplateModelProtocol
extension GitignoreTemplateModel: GitignoreTemplateModelProtocol {

    func fetchAvailableTemplateList() {
        apiClient.fetchAvailableTemplateList { [unowned self]  data, response, error in
            guard error == nil,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data,
                let list = try? JSONDecoder().decode([String].self, from: data)
            else {
                self.delegate?.gitignoreTemplateModel(self, didNotFetch: .templateListFetchingFailure)
                return
            }

            self.delegate?.gitignoreTemplateModel(self, didFetch: list)
        }
    }

    func fetchTemplateSource(of name: String) {
        apiClient.fetchTemplateSource(of: name) { [unowned self] data, response, error in
            guard error == nil,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data,
                let template = try? JSONDecoder().decode(GitignoreTemplate.self, from: data)
            else {
                if (error! as NSError).isURLCancelError {
                    self.delegate?.gitignoreTemplateModel(self, didNotFetch: .fetchingCancelled)
                } else {
                    self.delegate?.gitignoreTemplateModel(self, didNotFetch: .templateSourceFetchingFailure)
                }
                return
            }

            self.delegate?.gitignoreTemplateModel(self, didFetch: template.source)
        }
    }

    func cancelFetching() {
        apiClient.cancelFetching()
    }
}
