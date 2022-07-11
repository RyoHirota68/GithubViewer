//
//  SearchUserRequest.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/07.
//

import Foundation
import Alamofire

struct UserSearchRequest: BaseRequestProtocol {
    
    typealias ResponseType = UserSearchResponse
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return APIConstants.searchUsers.path
    }
    
    var url: String? {
        return nil
    }
    
    var parameters: [[String : Any]]? {
        let params = query
        return params
    }
    
    let query: [[String: Any]]
    
    init(query: [[String: Any]]) {
        self.query = query
    }
    
}
