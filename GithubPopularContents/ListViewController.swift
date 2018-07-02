//
//  ViewController.swift
//  GithubPopularContents
//
//  Created by 濱口和希 on 2018/07/01.
//  Copyright © 2018年 HamaguchiKazuki. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var repositoriesInfo = [RepositoryInfo]()
    let GithubUrl = "https://api.github.com/users/HamaguchiKazuki/repos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let githubUrl = URL(string: GithubUrl) else { return }
        getGithubUrl(url: githubUrl)
    }
    
    //MARK: - get githubAPI
    func getGithubUrl(url: URL) {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler:{
            (data, response, error) in
            do {
                let getJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                self.jsonProcessing(jsonData: getJson)
            } catch (let e) {
                print(e)
            }
        })
        task.resume()
    }
    
    func jsonProcessing(jsonData: NSArray) {
        
        for repositories in jsonData {
            let repository = repositories as! NSDictionary
            let name = repository["name"] as! String
            var codeLanguage: String
            if (repository["language"] as? String) == nil {
                codeLanguage = "No language"
            } else {
                codeLanguage = repository["language"] as! String
            }
            var repoDescription: String
            if (repository["description"] as? String) == nil {
                repoDescription = "No description"
            } else {
                repoDescription = repository["description"] as! String
            }
            let recentUpdate = repository["updated_at"] as! String
            let openIssues = repository["open_issues_count"] as! Int
            let defaultBranch = repository["default_branch"] as! String
            self.repositoriesInfo.append( RepositoryInfo(name: name, codeLanguage: codeLanguage, repoDescription: repoDescription, recentUpdate: recentUpdate, openIssues: openIssues, defaultBranch: defaultBranch) )
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.accessoryType = .none
        cell.textLabel?.text = "\(repositoriesInfo[indexPath.row].name)"
        cell.detailTextLabel?.text = "main use : \(repositoriesInfo[indexPath.row].codeLanguage)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesInfo.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let repoDescription = repositoriesInfo[indexPath.row].repoDescription
        let recentUpdate = repositoriesInfo[indexPath.row].recentUpdate
        let openIssues = repositoriesInfo[indexPath.row].openIssues
        let defaultBranch = repositoriesInfo[indexPath.row].defaultBranch
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.repoDescription = repoDescription
        controller.recentUpdate = recentUpdate
        controller.openIssues = openIssues
        controller.defaultBranch = defaultBranch
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
