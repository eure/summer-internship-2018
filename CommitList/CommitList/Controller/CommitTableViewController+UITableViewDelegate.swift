//
//  CommitTableViewController+UITableViewDelegate.swift
//  CommitList
//
//  Created by kawaguchi kohei on 2018/05/28.
//  Copyright © 2018年 kawaguchi kohei. All rights reserved.
//


import UIKit

extension CommitListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
