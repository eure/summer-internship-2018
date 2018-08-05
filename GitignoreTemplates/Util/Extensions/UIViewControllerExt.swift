//
//  SegueHandlerType.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentSingleDefaultActionAlert(title: String,
                                         message: String,
                                         actionTitle: String,
                                         actionHandler: ((UIAlertAction) -> Void)? = nil,
                                         animated: Bool = true,
                                         completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: actionHandler)
        alertController.addAction(action)

        present(alertController, animated: animated, completion: completion)
    }
}
