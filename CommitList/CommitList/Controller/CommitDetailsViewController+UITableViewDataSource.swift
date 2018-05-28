//
//  CommitTableViewController+UITableViewDataSource.swift
//  CommitList
//
//  Created by kawaguchi kohei on 2018/05/28.
//  Copyright © 2018年 kawaguchi kohei. All rights reserved.
//

import UIKit

extension CommitDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        guard let _commit = commit else {return cell}
        switch sectionName[indexPath.section] {
        case "Sha":
            cell.textLabel?.text = _commit.sha
        case "AuthorName":
            cell.textLabel?.text = _commit.name
        case "Email":
            cell.textLabel?.text = _commit.email
        case "Message":
            cell.textLabel?.text = _commit.message
        case "URL":
            cell.textLabel?.text = _commit.url?.absoluteString
        default:
            print("***section overflow")
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionName.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionName[section]
    }
    
}
