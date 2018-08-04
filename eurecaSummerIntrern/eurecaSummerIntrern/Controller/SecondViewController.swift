

import UIKit
import SwiftyJSON

class SecondViewController: UIViewController,UINavigationBarDelegate, UITextViewDelegate {
    
    var name:String?
    var count  = 0
    var image:UIImage?
    let CACHE_SEC : TimeInterval = 5 * 60; //5分キャッシュ
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var avatarUrl: UITextView!
    
    struct Acount {
        var  name:String = ""
        var urlString:String = ""
        var  avatar_url:String = ""
    }
    var root_acount = Acount()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarUrl.isSelectable = true
        avatarUrl.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.close))
        if root_acount.name.isEmpty{
            let string = "https://api.github.com/users/" + name!
            let compnents = URLComponents(string: string)
            let url = compnents?.url
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                if let data = data, let _ = response {
                    let json = JSON(data)
                    if json.isEmpty {
                    }else{
                        print(json)
                    }
                    var acount = Acount()
                    acount.name = json["login"].rawString()!
                    acount.urlString = json["html_url"].rawString()!
                    acount.avatar_url = json["avatar_url"].rawString()!
                    self.root_acount = acount
                    DispatchQueue.main.async {
                        self.viewDidLoad()
                    }
                } else {
                    print(error ?? "Error")
                }
            }
            task.resume()
        }else{
            user_name.text = root_acount.name
            
            let attributedString = NSMutableAttributedString(string: root_acount.urlString)
            attributedString.addAttribute(.link,
                                          value: root_acount.urlString,
                                          range: NSString(string: root_acount.urlString).range(of: root_acount.urlString))
            avatarUrl.attributedText = attributedString
            loadImage(urlString: root_acount.avatar_url)
        }
    }
    
    func loadImage(urlString: String){
        let req = URLRequest(url: NSURL(string:urlString)! as URL,
                             cachePolicy: .returnCacheDataElseLoad,
                             timeoutInterval: CACHE_SEC);
        let conf =  URLSessionConfiguration.default;
        let session = URLSession(configuration: conf, delegate: nil, delegateQueue: OperationQueue.main);
        session.dataTask(with: req, completionHandler:
            { (data, resp, err) in
                if((err) == nil){ //Success
                    let image = UIImage(data:data!)
                    self.image = image
                    self.Avatar.image = image
                }else{
                    print("AsyncImageView:Error \(String(describing: err?.localizedDescription))");
                }
        }).resume();
    }
    
    @objc func close()  {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
}
