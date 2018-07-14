import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class DetailViewController: UIViewController{
    
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var repositorySize: UILabel!
    var url:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepository()
    }
    
    //リポジトリの情報を取得する
    func getRepository() {
        Alamofire.request(url)
            .responseJSON{ response in
                guard let object = response.result.value else {
                    return
                }
                let statuscode = response.response?.statusCode
                if(statuscode == 200){
                    let json = JSON(object)
                    //Labelに取得した情報を表示
                    self.repositoryName.text = json["full_name"].string
                    self.userName.text = json["name"].string
                    self.createdDate.text = ((json["created_at"].string)?.replacingOccurrences(of: "T" , with: " "))?.replacingOccurrences(of: "Z", with: "")
                    self.language.text = json["language"].string
                    self.repositorySize.text = (json["size"].int)?.description
                }else{
                    self.repositoryName.text = "データの取得に失敗しました"
                }
        }
    }
    //一つ前（ViewController）への画面遷移
    @IBAction func backNavigationButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
