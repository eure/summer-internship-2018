//
//  GitignoreTemplateModelError.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

enum GitignoreTemplateModelError: Error {
    case templateListFetchFailure
    case templateSourceFetchFailure
}
