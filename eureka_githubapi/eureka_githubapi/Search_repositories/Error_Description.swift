//
//  Error_Description.swift
//  eureka_githubapi
//
//  Created by 村上拓麻 on 2018/07/21.
//  Copyright © 2018年 村上拓麻. All rights reserved.
//

import Foundation

/*エラー表示するときの文章*/

enum error : Error {
    case nothing_search
    case no_name
}


extension error : LocalizedError{
    var error_Descroption : String?{
        switch self {
        case .nothing_search:
            return "該当する結果が見つかりませんでした。😭"
        case .no_name:
            return "UserNameを入力して下さい。🖋"
        }
    }
}



