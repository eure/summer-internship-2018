//
//  GitignoreTemplateModelProtocol.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

protocol GitignoreTemplateModelProtocol: class {

    var delegate: GitignoreTemplateModelDelegate? { get set }

    func fetchAvailableTemplateList()
    func fetchTemplateSource(of name: String)
}
