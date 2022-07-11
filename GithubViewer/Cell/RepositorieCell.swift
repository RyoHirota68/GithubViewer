//
//  RepositryCell.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/10.
//

import UIKit

/// リポジトリ情報のCell
class RepositorieCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var languageColorView: UIView!
    @IBOutlet weak var descriptionLanel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(repositoriesModel: RepositoriesModel) {
        starLabel.text = String(repositoriesModel.stargazersCount)
        repoNameLabel.text = repositoriesModel.name
        if let lang = repositoriesModel.language {
            languageLabel.text = lang
            
            // githubの言語の色を設定
            languageColorView.backgroundColor = UIColor.init(language: lang)
            languageColorView.layer.cornerRadius = languageColorView.frame.size.height / 2
        } else {
            languageLabel.text = ""
        }
        if let description = repositoriesModel.description {
            descriptionLanel.text = description
        } else {
            descriptionLanel.text = ""
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
