//
//  DetailViewController.swift
//  GithubPopularContents
//
//  Created by 濱口和希 on 2018/07/01.
//  Copyright © 2018年 HamaguchiKazuki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var repoDescription: String!
    var recentUpdate: String!
    var openIssues: Int!
    var defaultBranch: String!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var recentUpdateLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionLabel.text = self.repoDescription
        self.recentUpdateLabel.text = "recent update time \n \n \(timeShaping(time: recentUpdate as NSString))"
        self.issueLabel.text = "total open issue \n \n \(self.openIssues.description)"
        self.branchLabel.text = "default branch \n \n \(self.defaultBranch!)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 時刻表示を整形(yyyy-mm-dd)
    func timeShaping(time: NSString) -> String {
        let rd = try? NSRegularExpression(pattern: "^(\\d{4})-(\\d{2})-(\\d{2})", options:  NSRegularExpression.Options() )
        if let r = rd?.firstMatch(in: time as String, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, time.length)) {
            print("\(time.substring(with: r.range(at: 1)))-\(time.substring(with: r.range(at: 2)))-\(time.substring(with: r.range(at: 3)))")
            return "\(time.substring(with: r.range(at: 1)))-\(time.substring(with: r.range(at: 2)))-\(time.substring(with: r.range(at: 3)))"
        }
        return""
    }
}
