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
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
