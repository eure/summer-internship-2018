//
//  TemplateViewController.swift
//  GitignoreTemplates
//
//  Created by Matsuoka Yoshiteru on 2018/07/31.
//  Copyright © 2018年 culumn. All rights reserved.
//

import UIKit

final class TemplateSourceViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    var model: GitignoreTemplateModelProtocol!
    var templateName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDependencies()
        configure()
        model.fetchTemplateSource(of: templateName)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // 画面を閉じる前にAPI通信をキャンセルする
        model.cancelFetching()
    }

    /// 依存を構築
    func configureDependencies() {
        let apiClient = GitignoreTemplateAPIClientImpl.shared
        let model = GitignoreTemplateModel(apiClient: apiClient)
        self.model = model
        model.delegate = self
    }

    func configure() {
        title = templateName
    }
}

// MARK: - GitignoreTemplateModelDelegate
extension TemplateSourceViewController: GitignoreTemplateModelDelegate {

    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol, didFetch templateList: [String]) {
    }

    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol, didFetch templateSource: String) {
        DispatchQueue.main.async { [unowned self] in
            self.indicator.stopAnimating()
            self.textView.text = templateSource
        }
    }

    func gitignoreTemplateModel(_ model: GitignoreTemplateModelProtocol, didNotFetch error: GitignoreTemplateModelError) {
        guard error == .templateSourceFetchingFailure else { return }
        DispatchQueue.main.async { [unowned self] in
            self.presentSingleDefaultActionAlert(title: "Error",
                                                 message: "Failed to get data\nPlease try again",
                                                 actionTitle: "OK",
                                                 actionHandler: { [unowned self] _ in
                                                    self.navigationController?.popViewController(animated: true)
            },
                                                 completion: { [unowned self] in
                                                    self.indicator.stopAnimating()
            })
        }
    }
}
