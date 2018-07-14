import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var eventTableView: UITableView!
    var Repositorys: [[String: String?]] = []
    var url:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepositoryEvent()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Repositorys.count
    }
    
    //eventTableViewに取得した情報を表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let Repository = Repositorys[indexPath.row]
        cell.textLabel?.text = Repository["repository"]!
        cell.detailTextLabel?.text = Repository["event"]!
        return cell
    }
    
    //公開リポジトリのイベント情報を取得する
    func getRepositoryEvent() {
        Repositorys.removeAll()
        Alamofire.request("https://api.github.com/events")
            .responseJSON{ response in
                guard let object = response.result.value else {
                    return
                }
                let statuscode = response.response?.statusCode
                if(statuscode == 200){
                    let json = JSON(object)
                    json.forEach{(_,json) in
                        let Repository: [String: String?] = [
                        "repository": json["repo"]["name"].string,
                        "event": json["type"].string,
                        "url": json["repo"]["url"].string
                    ]
                    self.Repositorys.append(Repository)
                    }
                }else{
                    self.Repositorys.append(["repository":"データの取得に失敗しました"])
                }
                self.eventTableView.reloadData()
        }
    }
    
    //eventTableViewの中身を最新のものにする
    @IBAction func refreshNavigationButton(_ sender: Any) {
        getRepositoryEvent()
    }
    
    //DetailViewControllerへの画面遷移
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        let Repository = Repositorys[indexPath.row]
        url = Repository["url"]!
        performSegue(withIdentifier: "toWebViewController",sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let DetailVC: DetailViewController = (segue.destination as? DetailViewController)!
        DetailVC.url = url
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

