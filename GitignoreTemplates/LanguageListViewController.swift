//
//  ViewController.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/07/31.
//  Copyright © 2018年 culumn. All rights reserved.
//

import UIKit

final class LanguageListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var languages = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    func configure() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func refresh() {
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension LanguageListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)

        cell.textLabel?.text = languages[indexPath.row]

        return cell
    }
}

// MARK: - UITableViewDelegate
extension LanguageListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)


    }
}
