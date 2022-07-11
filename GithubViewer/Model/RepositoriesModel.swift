//
//  RepositorieModel.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/10.
//

import Foundation
import Alamofire

struct RepositoriesModel: Codable {
    let name: String
    let htmlURL: String
    let description: String?
    let fork: Bool
    let language: String?
    let stargazersCount: Int
    
    enum Keys: String, CodingKey {
        case name
        case html_url
        case description
        case repos_url
        case fork
        case language
        case stargazers_count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.htmlURL = try container.decode(String.self, forKey: .html_url)
        self.description = try container.decode(String?.self, forKey: .description)
        self.fork = try container.decode(Bool.self, forKey: .fork)
        self.language = try container.decode(String?.self, forKey: .language)
        self.stargazersCount = try container.decode(Int.self, forKey: .stargazers_count)
    }
    
}
