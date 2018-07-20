//
//  ViewController.swift
//  GitHubAPI
//
//  Created by Takuma Matsushita on 2018/07/05.
//  Copyright © 2018年 Takuma Matsushita. All rights reserved.
//

import UIKit
import Moya
import RxMoya
import RxSwift
import RxCocoa
import Chameleon
import SwiftIconFont
import Smile

class SearchViewController: UIViewController {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // TODO: - auto-sizing
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 90)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(RepositoryCollectionViewCell.self, forCellWithReuseIdentifier: "repo")
        return collectionView
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        return searchBar
    }()
    
    let provider = MoyaProvider<GitHubAPI>()
    var repositories = Variable<[Repository]>([])
    
    var disposeBag = DisposeBag()
    
    var page = 0
    var isLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search"
       
        setupViews()
        setupConstraints()
        setupRx()
    }
    
    func setupRx() {
        searchBar.rx.text.orEmpty
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { str in
                self.repositories.value = []
                self.page = 0
                self.getSearchResult(query: str)
            }).disposed(by: disposeBag)
        
        repositories.asObservable().bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "repo", for: indexPath) as! RepositoryCollectionViewCell
            
            cell.nameLabel.text = Smile.replaceAlias(string: self.repositories.value[row].full_name)
            cell.langLabel.text = self.repositories.value[row].language
            cell.starCountLabel.text = self.repositories.value[row].stargazers_count.suffixNumber()
            
            if let date = self.repositories.value[row].updated_at.dateFormat() {
                cell.updatedDateLabel.text = "Updated \(date)"
            } else {
                cell.updatedDateLabel.text = "Unknown"
            }
            
            if let desc = self.repositories.value[row].description {
                cell.descLabel.text = Smile.replaceAlias(string: desc)
            } else {
                cell.descLabel.text = "No description provided."
                cell.descLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
            }
            
            if let lang = self.repositories.value[row].language {
                cell.langColorCircle.backgroundColor = UIColor().getGitHubColors(name: lang)
            }
            
            return cell
            }.disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            let repositoriViewController = RepositoryViewController()
            repositoriViewController.repository = self.repositories.value[indexPath.row]
            self.navigationController?.pushViewController(repositoriViewController, animated: true)
        }).disposed(by: disposeBag)
        
        collectionView.rx.contentOffset
            .flatMap { offset in
                self.isNearTheBottomEdge(contentOffset: offset, self.collectionView)
                    ? Observable.just(offset)
                    : Observable.empty()
            }.subscribe(onNext: { _ in
                guard let query = self.searchBar.text else { return }
                self.getSearchResult(query: query)
            }).disposed(by: disposeBag)
    }
    
    func setupViews() {
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.view.safeAreaLayoutGuide
        self.searchBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.searchBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        self.searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func getSearchResult(query: String) {
        // TODO: handle the completion
        if isLoading { return }
        isLoading = true
        provider.rx.request(.search(q: query, page: page))
            .filterSuccessfulStatusCodes()
            .map(SearchResult.self)
            .subscribe(onSuccess: { res in
                guard let items = res.items else { return }
                if self.repositories.value.isEmpty {
                    self.repositories.value = items
                } else {
                    self.repositories.value += items
                }
                self.page += 1
                self.isLoading = false
            }, onError: { err in
                print(err)
                self.isLoading = false
            }).disposed(by: disposeBag)
    }
    
    func isNearTheBottomEdge(contentOffset: CGPoint, _ collectionView: UICollectionView) -> Bool {
        let startLoadingOffset: CGFloat = 20.0
        return contentOffset.y + collectionView.frame.size.height + startLoadingOffset > collectionView.contentSize.height
    }
}

// MARK: - Cell

class RepositoryCollectionViewCell: UICollectionViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .flatBlack()
        return label
    }()
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    var starCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.sizeToFit()
        return label
    }()
    
    var starIconLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.icon(from: .fontAwesome, ofSize: 14)
        label.text = String.fontAwesomeIcon("star")
        label.textColor = .darkGray
        label.sizeToFit()
        return label
    }()
    
    var updatedDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.sizeToFit()
        return label
    }()
    
    var langLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.sizeToFit()
        return label
    }()

    var langColorCircle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.layer.cornerRadius = 5
        view.backgroundColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(descLabel)
        self.contentView.addSubview(langColorCircle)
        self.contentView.addSubview(langLabel)
        self.contentView.addSubview(starIconLabel)
        self.contentView.addSubview(starCountLabel)
        self.contentView.addSubview(updatedDateLabel)
    }
    
    func setupConstraints() {
        let guide = contentView.layoutMarginsGuide
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        self.descLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        self.descLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.descLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        
        self.langColorCircle.translatesAutoresizingMaskIntoConstraints = false
        self.langColorCircle.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10).isActive = true
        self.langColorCircle.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
        self.langColorCircle.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.langColorCircle.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
        
        self.langLabel.translatesAutoresizingMaskIntoConstraints = false
        self.langLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5).isActive = true
        self.langLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        self.langLabel.leadingAnchor.constraint(equalTo: langColorCircle.trailingAnchor, constant: 5).isActive = true
        
        self.starIconLabel.translatesAutoresizingMaskIntoConstraints = false
        self.starIconLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5).isActive = true
        self.starIconLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        self.starIconLabel.leadingAnchor.constraint(equalTo: langLabel.trailingAnchor, constant: 10).isActive = true
        
        self.starCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.starCountLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5).isActive = true
        self.starCountLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        self.starCountLabel.leadingAnchor.constraint(equalTo: starIconLabel.trailingAnchor, constant: 3).isActive = true
        
        self.updatedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.updatedDateLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5).isActive = true
        self.updatedDateLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        self.updatedDateLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Extension

extension String {
    func dateFormat() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = formatter.date(from: self) else { return nil }
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: date)
    }
}

extension Int {
    func suffixNumber() -> String {
        if self < 1000 {
            return "\(self)"
        }
        let n = Double(self)
        let exp = Int(log10(n) / 3.0)
        let units = ["k", "m", "g"]
        let rounded = round(10 * n / pow(1000.0, Double(exp))) / 10
        return "\(rounded)\(units[exp-1])"
    }
}

