//
//  CommitDetailsViewController+UITableViewDelegate.swift
//  CommitList
//
//  Created by kawaguchi kohei on 2018/05/28.
//  Copyright © 2018年 kawaguchi kohei. All rights reserved.
//

import Foundation
import UIKit

extension CommitDetailsViewController: UITableViewDelegate{
    //urlを押されたらsafariで開く
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = commit?.url else {return}
        if sectionName[indexPath.section] == "URL"{
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: {(isOpenSuccess) in
                    if isOpenSuccess {
                        print("*** open url")
                    }
                    else{
                        print("*** error open url")
                    }
                })
            }
        }
    }
}
