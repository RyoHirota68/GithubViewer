//
//  AnyObject+ClassName.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/10.
//

import Foundation



/// class名を返すextention
/// 例) V.className でVのクラス名を取得できる
public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        String(describing: self)
    }

    var className: String {
        Self.className
    }
}

extension NSObject: ClassNameProtocol {}
