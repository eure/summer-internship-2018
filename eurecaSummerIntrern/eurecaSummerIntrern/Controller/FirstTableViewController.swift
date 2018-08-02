//
//  FirstTableViewController.swift
//  eurecaSummerIntrern
//
//  Created by 近藤大翔 on 2018/08/02.
//  Copyright © 2018年 近藤大翔. All rights reserved.
//

import UIKit
import SwiftyJSON

class FirstTableViewController: UITableViewController {
    struct feedApiInfo {
        var name: String = ""
        var type: String = ""
    }
    var array:[feedApiInfo] = []



    override func viewDidLoad() {
        super.viewDidLoad()
        //let queryItems = [ URLQueryItem(name:"operation",value: "searchRetrieve")]
        let compnents = URLComponents(string: "https://api.github.com/repos/eure/summer-internship-2018/events")
        //compnents?.queryItems = queryItems
        let url = compnents?.url
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data, let response = response {
                print(response)
                let json = JSON(data)
                if json.isEmpty {
                }else{
                    print(json)
                }
                for index in 0...19 {
                    var feed = feedApiInfo()
                    feed.type = json[index]["type"].rawString()!
                    feed.name = json[index]["actor"]["display_login"].rawString()!
                    self.array.append(feed)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print(error ?? "Error")
            }
        }
        task.resume()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "aaa")
        cell.detailTextLabel?.text = array[indexPath.row].type
        cell.textLabel?.text = array[indexPath.row].name
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
