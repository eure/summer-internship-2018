//
//  UIStoryboardExt.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import UIKit

extension UIStoryboard {

    enum ViewControllerType {
        case languageVC
        case templateSourceVC

        var identifier: String {
            switch self {
            case .languageVC:
                return "LanguageListViewController"
            case .templateSourceVC:
                return "TemplateViewController"
            }
        }
    }

    func instantiateViewController(withType: ViewControllerType) -> UIViewController {
        return instantiateViewController(withIdentifier: withType.identifier)
    }
}
