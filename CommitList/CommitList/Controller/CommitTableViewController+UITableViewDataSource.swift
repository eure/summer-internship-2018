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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.commitTableViewCellIdentifer, for: indexPath) as! CommitTableViewCell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
