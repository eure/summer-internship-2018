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

    var model: GitignoreTemplateModelProtocol!
    var languages = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        model.fetchAvailableTemplateList()
    }

    func configure() {
        let apiClient = GitignoreTemplateAPIClientImpl.shared
        let model = GitignoreTemplateModel(apiClient: apiClient)
        self.model = model
        model.delegate = self

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func refresh() {
        model.fetchAvailableTemplateList()
    }
}

// MARK: - SegueHandler
extension LanguageListViewController: SegueHandler {

    enum SegueIdentifier: String {
        case templateSource = "ToTemplateSource"
    }

    func performSegueWithIdentifier(segueIdentifier: LanguageListViewController.SegueIdentifier, sender: AnyObject?) {
        switch segueIdentifier {
        case .templateSource:
            guard let sourceVC = storyboard?.instantiateViewController(withType: .templateSourceVC) as? TemplateSourceViewController else { return }

        }
    }
}

// MARK: - UITableViewDataSource
extension LanguageListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: .languageCell, for: indexPath)
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

// MARK: - GitignoreTemplateModelDelegate
extension LanguageListViewController: GitignoreTemplateModelDelegate {

    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol, didFetch templateList: [String]) {
        languages = templateList

        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()

            self.tableView.beginUpdates()
            self.tableView.reloadSections([0], with: .automatic)
            self.tableView.endUpdates()
        }
    }

    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol, didFetch templateSource: String) {
    }

    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol, didNotFetch error: GitignoreTemplateModelError) {
        // TODO: Error Handling
    }
}
