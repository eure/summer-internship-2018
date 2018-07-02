//
//  DetailViewController.swift
//  GithubPopularContents
//
//  Created by 濱口和希 on 2018/07/01.
//  Copyright © 2018年 HamaguchiKazuki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var repoDescription: String?
    var recentUpdate: String?
    var openIssues: Int?
    var defaultBranch: String?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var recentUpdateLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionLabel.text = self.repoDescription
        self.recentUpdateLabel.text = "recent update time \n \n \(self.recentUpdate!)"
        self.issueLabel.text = "total open issue \n \n \((self.openIssues?.description)!)"
        self.branchLabel.text = "default branch \n \n \(self.defaultBranch!)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
