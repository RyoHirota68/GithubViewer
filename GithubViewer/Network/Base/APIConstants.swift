//
//  APIConstants.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/07.
//

import Foundation
import Alamofire

// MARK: - Constants
enum APIConstants {
    case searchUsers
    case user

    public var path: String {
        switch self {
        case .searchUsers: return "search/users"
        case .user: return "user"
        }
    }

    public static var baseURL = "https://api.github.com"

    static let token = "" //tokenを設定
    public static var header: [String : String]? {
        return [
            "Accept": "application/json",
            "Authorization": token
        ]
    }
}
