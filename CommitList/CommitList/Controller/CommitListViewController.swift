//
//  CommitListViewController.swift
//  CommitList
//
//  Created by kawaguchi kohei on 2018/05/28.
//  Copyright © 2018年 kawaguchi kohei. All rights reserved.
//

import UIKit

class CommitListViewController: UIViewController {
    @IBOutlet weak var commitTableView: UITableView!
    let commitManager = CommitManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commitManager.fetch()
        // delegateやxibの登録
        setUpTableView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //復帰時に選択を解除
        self.commitTableView.indexPathsForSelectedRows?.forEach {
            self.commitTableView.deselectRow(at: $0, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpTableView(){
        self.commitTableView.delegate = self
        self.commitTableView.dataSource = self
        self.commitTableView.register(UINib(nibName: Strings.commitTableViewCell, bundle: nil), forCellReuseIdentifier: Strings.commitTableViewCellIdentifer)
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
