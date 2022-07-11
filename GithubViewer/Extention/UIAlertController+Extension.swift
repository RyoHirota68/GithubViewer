//
//  UIAlertController+Extension.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/11.
//

import UIKit

extension UIAlertController {
    func createAlert(withTitle title: String, message : String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        }
        alertController.addAction(OKAction)
        return alertController
    }
}
