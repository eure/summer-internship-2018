//
//  CommitTableViewController+UITableViewDataSource.swift
//  CommitList
//
//  Created by kawaguchi kohei on 2018/05/28.
//  Copyright © 2018年 kawaguchi kohei. All rights reserved.
//

import UIKit

extension CommitListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitManager.commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.commitTableViewCellIdentifer, for: indexPath) as! CommitTableViewCell
        let commit = commitManager.commits[indexPath.row]
        cell.nameLabel?.text = commit.name
        cell.messageLabel?.text = commit.message
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
