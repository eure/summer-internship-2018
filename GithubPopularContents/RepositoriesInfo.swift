//
//  RepositoriesInfo.swift
//  GithubPopularContents
//
//  Created by 濱口和希 on 2018/07/02.
//  Copyright © 2018年 HamaguchiKazuki. All rights reserved.
//

struct RepositoryInfo {
    var name: String
    var codeLanguage: String
    var repoDescription: String
    var recentUpdate: String
    var openIssues: Int
    var defaultBranch: String
    
    init(name: String, codeLanguage: String, repoDescription: String, recentUpdate: String, openIssues: Int, defaultBranch: String) {
        self.name =  name
        self.codeLanguage = codeLanguage
        self.repoDescription = repoDescription
        self.recentUpdate = recentUpdate
        self.openIssues = openIssues
        self.defaultBranch = defaultBranch
    }
}
