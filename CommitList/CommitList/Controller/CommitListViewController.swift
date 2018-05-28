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
        
        let activityIndicatorView = createActivityIndicatorView()
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        commitManager.fetch(){
            activityIndicatorView.stopAnimating()
            self.commitTableView.reloadData()
        }
        // delegateやxibの登録
        setUpTableView()
        
        self.title = Strings.commitListViewTitleText
        
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
    
    private func createActivityIndicatorView() -> UIActivityIndicatorView{
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicatorView.center = self.view.center
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        activityIndicatorView.hidesWhenStopped = true
        
        return activityIndicatorView
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
