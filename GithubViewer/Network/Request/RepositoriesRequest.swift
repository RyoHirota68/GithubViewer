//
//  RepositorieRequest.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/10.
//

import Foundation
import Alamofire

struct RepositoriesRequest: BaseRequestProtocol {
    
    typealias ResponseType = [RepositoriesModel]
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var path: String {
        return ""
    }

    var url: String? {
        let userPageURL = self.userPageURL
        return userPageURL
    }
    
    var parameters: [[String : Any]]? {
        let params = query
        return params
    }
    
    var query: [[String: Any]]? = nil
    let userPageURL: String
    
    init(userPageURL: String, query: [[String: Any]]?) {
        self.userPageURL = userPageURL
        if let query = query {
            self.query = query
        }
    }
    
}
