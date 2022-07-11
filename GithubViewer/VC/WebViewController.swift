//
//  WebViewController.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/11.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var urlString: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.backgroundColor = .clear
        let request = URLRequest(url: URL(string: urlString!)!)
        webView.load(request)
    }
}
