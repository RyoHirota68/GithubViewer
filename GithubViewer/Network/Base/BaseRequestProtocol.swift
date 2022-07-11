//
//  RequestProtocol.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/07.
//

import Foundation
import Alamofire

protocol BaseRequestProtocol: BaseAPIProtocol, URLRequestConvertible {
    var parameters: [[String:Any]]? { get }
    var encoding: URLEncoding { get }
    var url: String? { get }
}

extension BaseRequestProtocol {
    var encoding: URLEncoding {
        return URLEncoding.default
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest: URLRequest
        if let url = self.url {
            urlRequest = URLRequest(url: URL(string: url)!)
        } else {
            urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        }

        urlRequest.httpMethod = method.rawValue

        urlRequest.allHTTPHeaderFields = headers

        urlRequest.timeoutInterval = TimeInterval(30)

        // parameterの付与
        if let parameters = self.parameters {
            for (_, param) in parameters.enumerated() {
                urlRequest = try encoding.encode(urlRequest, with: param)
            }
        }
        
        return urlRequest
    }

}
