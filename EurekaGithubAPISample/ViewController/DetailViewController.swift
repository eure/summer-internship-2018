//
//  DetailViewController.swift
//  EurekaGithubAPISample
//
//  Created by Azuma on 2018/07/05.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    var detail: String = ""
    var ownerName: String = ""
    var repoName: String = ""
    var htmlURL: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = repoName
        self.detailTextView.text = detail
        if UIApplication.shared.canOpenURL(URL(string: htmlURL)!) {
            searchButton.isEnabled = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        APIClient.fetchReadMe(ownerName: ownerName, repoName: repoName) { (detail) in
            let content = String(data: Data(base64Encoded: detail.content, options:Data.Base64DecodingOptions.ignoreUnknownCharacters)!, encoding: .utf8)
            DispatchQueue.main.async {
                self.detailTextView.text = content
            }
        }
    }
    
    @IBAction func search(_ sender: Any) {
        let url = URL(string: htmlURL)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
