import UIKit
import WebKit
import Foundation
import Alamofire
import SwiftyJSON

class WebViewController: UIViewController, WKNavigationDelegate{
    
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
    
    func getRepository() {
        Alamofire.request(url)
            .responseJSON{ response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json)
                self.repositoryName.text = json["full_name"].string
                self.userName.text = json["name"].string
                self.createdDate.text = json["created_at"].string
                self.language.text = json["language"].string
                self.repositorySize.text = (json["size"].int)?.description
        }
    }
    
    @IBAction func backNavigationButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
