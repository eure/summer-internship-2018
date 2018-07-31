//
//  GitignoreTemplateModelProtocolDelegate.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

protocol GitignoreTemplateModelProtocolDelegate: class {
    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol,
                                didFetch templateList: [String])
    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol,
                                didFetch templateSource: String)
    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol,
                                didNotFetch error: GitignoreTemplateModelError)
}
