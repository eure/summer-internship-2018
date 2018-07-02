//
//  ViewController.swift
//  GithubPopularContents
//
//  Created by 濱口和希 on 2018/07/01.
//  Copyright © 2018年 HamaguchiKazuki. All rights reserved.
//

import UIKit

struct RepositoryInfo {
    var name: String
    var codeLanguage: String
    var repoDescription: String
    var recentUpdate: String
    var openIssues: Int
    var defaultBranch: String
    
    init(name: String, codeLanguage: String, repoDescription: String, recentUpdate: String, openIssues: Int, defaultBranch: String) {
        self.name = name
        self.codeLanguage = codeLanguage
        self.repoDescription = repoDescription
        self.recentUpdate = recentUpdate
        self.openIssues = openIssues
        self.defaultBranch = defaultBranch
    }
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var repositoriesInfo = [RepositoryInfo]()
    var selectedInfo: Any?
    let GithubUrl = "https://api.github.com/users/HamaguchiKazuki/repos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - get githubAPI
        if let url = URL(string: GithubUrl) {
            let req = NSMutableURLRequest(url: url)
            req.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler:{
                (data, resp, err) in
                do {
                    let getJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                    
                    for repositories in getJson {
                        let repository = repositories as! NSDictionary
                        let name = repository["name"] as! String
                        var codeLanguage: String
                        let languageNilCheck = repository["language"] as? String
                        if languageNilCheck == nil {
                            codeLanguage = "No language"
                        } else {
                            codeLanguage = repository["language"] as! String
                        }
                        var repoDescription: String
                        let descriptionNilCheck = repository["description"] as? String
                        if descriptionNilCheck == nil {
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
                } catch (let e) {
                    print(e)
                }
            })
            task.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Segues
    func perpare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let repoDescription = repositoriesInfo[indexPath.row].repoDescription
                let recentUpdate = repositoriesInfo[indexPath.row].recentUpdate
                let openIssues = repositoriesInfo[indexPath.row].openIssues
                let defaultBranch = repositoriesInfo[indexPath.row].defaultBranch
                
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.repoDescription = repoDescription
                controller.recentUpdate = recentUpdate
                controller.openIssues = openIssues
                controller.defaultBranch = defaultBranch
            }
        }
    }
    
    //MARK: - TableView
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
