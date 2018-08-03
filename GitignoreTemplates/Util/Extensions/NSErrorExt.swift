//
//  ErrorExt.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import Foundation

extension NSError {

    var isURLCancelError: Bool {
        return domain == "NSURLErrorDomain" &&
            code == -999
    }
}
