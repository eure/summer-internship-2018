//
//  RepositoryViewController.swift
//  GitHubAPI
//
//  Created by Takuma Matsushita on 2018/07/06.
//  Copyright © 2018年 Takuma Matsushita. All rights reserved.
//

import Foundation
import UIKit
import RxMoya
import Moya
import RxSwift
import MarkdownView
import SafariServices

class RepositoryViewController: UIViewController {
    
    var repository: Repository!
    
    var markdownView: MarkdownView = {
        let md = MarkdownView()
        return md
    }()
    
    var descTextView: UITextView = {
        let textView = UITextView()
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isEditable = false
        return textView
    }()
    
    var starButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    var disposedBag = DisposeBag()
    
    // TODO: singleton
    let provider = MoyaProvider<GitHubAPI>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = repository.full_name
        
        let safariButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(openSafari))
        self.navigationItem.rightBarButtonItem = safariButton
        
        provider.rx.request(.readme(fullName: self.repository.full_name))
            .filterSuccessfulStatusCodes()
            .map(Readme.self)
            .subscribe(onSuccess: { res in
                guard let md = self.encodeMarkdown(base64: res.content) else { return }
                self.markdownView.load(markdown: md)
            }, onError: { err in
                print(err)
            }).disposed(by: disposedBag)
        
        markdownView.onTouchLink = { [weak self] request in
            guard let url = request.url else { return false }
            switch url.scheme {
            case "file":
                return false
            case "https":
                let safari = SFSafariViewController(url: url)
                self?.present(safari, animated: true, completion: nil)
                return false
            default:
                return false
            }
        }
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.addSubview(markdownView)
    }
    
    func setupConstraints() {
        let guide = self.view.safeAreaLayoutGuide
        
        self.markdownView.translatesAutoresizingMaskIntoConstraints = false
        self.markdownView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        self.markdownView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.markdownView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.markdownView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @objc func openSafari() {
        print(self.repository.html_url)
        guard let url = URL(string: self.repository.html_url) else { return }
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func encodeMarkdown(base64: String) -> String? {
        let str = base64.replacingOccurrences(of: "\n", with: "")
        guard let contentData = Data(base64Encoded: str) else { return nil }
        guard let md = String(data: contentData, encoding: .utf8) else { return nil}
        return md
    }
}
