//
//  UserDetailModel.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/09.
//

import Foundation
import Alamofire

struct UserDetailModel: Codable {
    let login: String
    let avaterURL: String
    let reposURL: String
    let name: String?
    let bio: String?
    let publicRepos: Int
    let followers: Int
    let following: Int
    
    enum Keys: String, CodingKey {
        case login
        case avatar_url
        case repos_url
        case name
        case bio
        case public_repos
        case followers
        case following
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.login = try container.decode(String.self, forKey: .login)
        self.avaterURL = try container.decode(String.self, forKey: .avatar_url)
        self.reposURL = try container.decode(String.self, forKey: .repos_url)
        self.name = try container.decode(String?.self, forKey: .name)
        self.bio = try container.decode(String?.self, forKey: .bio)
        self.publicRepos = try container.decode(Int.self, forKey: .public_repos)
        self.followers = try container.decode(Int.self, forKey: .followers)
        self.following = try container.decode(Int.self, forKey: .following)
    }
    
}
