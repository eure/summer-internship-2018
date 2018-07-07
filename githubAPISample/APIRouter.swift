//
//  WebAPI.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/05.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Alamofire

//GitHubのAPIのルーティング
enum APIRouter: URLRequestConvertible {
    
    case users //ユーザー一覧の取得
    case user(name: String)//１ユーザーの取得
    
    ///それぞれのケースでのHTTPメソッドの指定
    private var method: HTTPMethod {
        switch self {
        case .users:
            return .get
        case .user:
            return .get
        }
    }
    
    /// アクセス先のPathを保持
    private var path: String {
        switch self {
        case .users:
            return "/users"
        case .user(let name):
            return "/users/\(name)"
        }
    }
    
    /// 生成したAPIをリクエストの形にして返す関数
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        urlRequest.httpMethod = self.method.rawValue
        return urlRequest
    }
}
