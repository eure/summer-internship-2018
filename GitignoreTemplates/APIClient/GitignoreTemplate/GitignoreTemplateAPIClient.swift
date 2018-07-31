//
//  APIClient.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

protocol GitignoreTemplateAPIClient: class {
    func fetchAvailableTemplateList(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    func fetchTemplateSource(of name: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}
