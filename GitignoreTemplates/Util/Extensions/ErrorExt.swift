//
//  ErrorExt.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

extension Error {

    var isURLCancelError: Bool {
        let error = self as NSError

        return error.domain == "NSURLErrorDomain" &&
            error.code == -999
    }
}
