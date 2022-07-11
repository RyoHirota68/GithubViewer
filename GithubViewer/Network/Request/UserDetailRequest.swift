//
//  UserRequest.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/09.
//

import Foundation
import Alamofire

struct UserDetailRequest: BaseRequestProtocol {
    typealias ResponseType = UserDetailModel
    
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
        return nil
    }
    
    let userPageURL: String
    
    init(userPageURL: String) {
        self.userPageURL = userPageURL
    }
    
}
