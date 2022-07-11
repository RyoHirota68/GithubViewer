//
//  UIImageView+URL.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/09.
//

import UIKit
import Nuke

/// Nukeで画像取得
/// 例) imageView.loadImage(with: "https://~~~~")
extension UIImageView {
    func loadImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        loadImage(with: url)
    }

    func loadImage(with url: URL) {
        Nuke.loadImage(with: url, into: self)
    }
}
