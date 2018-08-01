//
//  ViewController.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/07/31.
//  Copyright © 2018年 culumn. All rights reserved.
//

import UIKit

final class LanguageListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var model: GitignoreTemplateModelProtocol!
    var languages = [String]()
    var filterLanguages = [String]()
    var isFiltering = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDependencies()
        configure()
        model.fetchAvailableTemplateList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // modelのdelegateを自身にセットし直す
        model.delegate = self
    }

    @IBAction func didTapSearchButton(_ sender: UIBarButtonItem) {
        setSearchBarHiddenWithAnimation(false)
    }

    /// 依存を構築
    func configureDependencies() {
        let apiClient = GitignoreTemplateAPIClientImpl.shared
        let model = GitignoreTemplateModel(apiClient: apiClient)
        self.model = model
        model.delegate = self
    }

    func configure() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func refresh() {
        model.fetchAvailableTemplateList()
    }

    func reloadTableViewWithAnimation() {
        if #available(iOS 11.0, *) {
            tableView.performBatchUpdates({ [unowned self] in
                self.tableView.reloadSections([0], with: .automatic)
            })
        } else {
            tableView.beginUpdates()
            tableView.reloadSections([0], with: .automatic)
            tableView.endUpdates()
        }
    }

    func clearFiltering() {
        isFiltering = false
        filterLanguages = []
    }

    func setSearchBarHiddenWithAnimation(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.searchBar.isHidden = isHidden

            if !isHidden {
                self.searchBar.becomeFirstResponder()
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension LanguageListViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            // 入力されたテキストが空なので、フィルタリングをクリア
            clearFiltering()
            reloadTableViewWithAnimation()
            return
        }

        //  入力されたテキストを使い、言語一覧を前方一致で検索
        isFiltering = true
        filterLanguages = languages.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
        reloadTableViewWithAnimation()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.endEditing(true)

        clearFiltering()
        reloadTableViewWithAnimation()
        setSearchBarHiddenWithAnimation(true)
    }
}

// MARK: - UITableViewDataSource
extension LanguageListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isFiltering else { return languages.count }
        return filterLanguages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: .languageCell, for: indexPath)

        if isFiltering {
            cell.textLabel?.text = filterLanguages[indexPath.row]
        } else {
            cell.textLabel?.text = languages[indexPath.row]
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LanguageListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let sourceVC = storyboard?.instantiateViewController(withType: .templateSourceVC) as? TemplateSourceViewController else { return }
        if isFiltering {
            sourceVC.templateName = filterLanguages[indexPath.row]
        } else {
            sourceVC.templateName = languages[indexPath.row]
        }

        // 共通のmodelを渡す
        sourceVC.model = model

        navigationController?.pushViewController(sourceVC, animated: true)
    }
}

// MARK: - GitignoreTemplateModelDelegate
extension LanguageListViewController: GitignoreTemplateModelDelegate {

    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol, didFetch templateList: [String]) {
        languages = templateList

        DispatchQueue.main.async { [unowned self] in
            self.tableView.refreshControl?.endRefreshing()
            self.reloadTableViewWithAnimation()
        }
    }

    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol, didFetch templateSource: String) {
    }

    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol, didNotFetch error: GitignoreTemplateModelError) {
        DispatchQueue.main.async { [unowned self] in
            self.presentSingleDefaultActionAlert(title: "Error",
                                                 message: "Failed to get data\nPlease try again",
                                                 actionTitle: "OK",
                                                 completion: { [unowned self] in
                                                    self.tableView.refreshControl?.endRefreshing()
            })
        }
    }
}
