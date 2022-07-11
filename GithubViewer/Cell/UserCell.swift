//
//  UserCell.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/09.
//

import UIKit
import Nuke

/// ユーザー情報のCell
class UserCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var userPageURL: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(userModel: UserModel) {
        userNameLabel.text = userModel.login
        iconImageView.loadImage(with: userModel.avatarUrl)
        userPageURL = userModel.url
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        print(userPageURL)
        // Configure the view for the selected state
    }
    
}
