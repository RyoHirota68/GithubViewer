//
//  BaseAPIProtocol.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/07.
//

import Foundation
import Alamofire

protocol BaseAPIProtocol {
    associatedtype ResponseType: Codable
    
    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var headers: [String : String]? { get }
    var decode: (Data) throws -> ResponseType { get }
}

extension BaseAPIProtocol {
    
    var baseURL: URL {
        return try! APIConstants.baseURL.asURL()
    }
    
    var headers: [String : String]? {
        return APIConstants.header
    }
    
    var decode: (Data) throws -> ResponseType {
        return {try JSONDecoder.decoder.decode(ResponseType.self, from: $0)}
    }
}
