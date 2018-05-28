//
//  CommitDetailsViewController.swift
//  CommitList
//
//  Created by kawaguchi kohei on 2018/05/28.
//  Copyright © 2018年 kawaguchi kohei. All rights reserved.
//

import UIKit

class CommitDetailsViewController: UIViewController {
    @IBOutlet weak var detailsTableView: UITableView!
    var commit: Commit? = nil
    let sectionName = ["Sha", "AuthorName", "Email", "Message", "URL"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.dataSource = self
        self.title = Strings.commitDetailsViewTitleText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
