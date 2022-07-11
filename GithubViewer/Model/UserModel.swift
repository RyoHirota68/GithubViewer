//
//  UserModel.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/07.
//

import Foundation
import Alamofire

struct UserSearchResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [UserModel]
    
    enum Keys: String, CodingKey {
        case total_count
        case incomplete_results
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.totalCount = try container.decode(Int.self, forKey: .total_count)
        self.incompleteResults = try container.decode(Bool.self, forKey: .incomplete_results)
        self.items = try container.decode([UserModel].self, forKey: .items)
    }
    
}

struct UserModel: Codable {
    let login: String //UserName
    let avatarUrl: String //IconImageURL
    let url: String
    
    enum Keys: String, CodingKey {
        case login
        case avatar_url
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarUrl = try container.decode(String.self, forKey: .avatar_url)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
