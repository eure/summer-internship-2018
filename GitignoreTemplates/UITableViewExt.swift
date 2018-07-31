//
//  UITableViewExt.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/08/01.
//  Copyright © 2018年 culumn. All rights reserved.
//

import UIKit

extension UITableView {

    enum UITableViewCellType {
        case languageCell

        var identifier: String {
            switch self {
            case .languageCell:
                return "LanguageCell"
            }
        }
    }

    func dequeueReusableCell(withType: UITableViewCellType, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: withType.identifier, for: indexPath)
    }
}
