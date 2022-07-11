//
//  JSONDecoder+Extension.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/09.
//

import Foundation

extension JSONDecoder {

    convenience init(type: JSONDecoder.KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = type
    }

    static let decoder: JSONDecoder = JSONDecoder(type: .convertFromSnakeCase)
}
