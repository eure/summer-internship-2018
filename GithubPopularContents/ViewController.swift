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
    var htmlUrl: String
    var repoDescription: String
    var codeLanguage: String
    var defaultBranch: String
    
    init(name: String, htmlUrl: String, repoDescription: String, codeLanguage: String, defaultBranch: String) {
        self.name = name
        self.htmlUrl = htmlUrl
        self.repoDescription = repoDescription
        self.codeLanguage = codeLanguage
        self.defaultBranch = defaultBranch
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let tableView = UITableView()
    var repositoriesInfo = [RepositoryInfo]()
    let GithubUrl = "https://api.github.com/users/HamaguchiKazuki/repos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - UITableView Setting
        tableView.frame = CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: self.view.frame.height - statusBarHeight)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
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
                        let htmlUrl = repository["html_url"] as! String
                        let defaultBranch = repository["default_branch"] as! String
                        var repoDescription: String
                        let descriptionNilCheck = repository["description"] as? String
                        if descriptionNilCheck == nil {
                            repoDescription = "No description"
                        } else {
                            repoDescription = repository["description"] as! String
                        }
                        var codeLanguage: String
                        let languageNilCheck = repository["language"] as? String
                        if languageNilCheck == nil {
                            codeLanguage = "No language"
                        } else {
                            codeLanguage = repository["language"] as! String
                        }
                        self.repositoriesInfo.append( RepositoryInfo(name: name, htmlUrl: htmlUrl, repoDescription: repoDescription, codeLanguage: codeLanguage, defaultBranch: defaultBranch) )
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
    
    
    //MARK: - TableView
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.accessoryType = .none
        cell.textLabel?.text = "\(repositoriesInfo[indexPath.row].name)"
        cell.detailTextLabel?.text = "\(repositoriesInfo[indexPath.row].repoDescription)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesInfo.count
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

