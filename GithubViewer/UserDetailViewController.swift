//
//  UserDetailViewController.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/10.
//

import UIKit
import RxSwift

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var repositryCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var currentPage = 1
    private let prePage:Double = 30
    private var maxPage: Int = 0
    
    var userDetailModel: UserDetailModel!
    let disposeBag = DisposeBag()
    
    private var repositoriesModel: [RepositoriesModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RepositorieCell", bundle: nil), forCellReuseIdentifier: "RepositorieCell")
        maxPage = Int(ceil(Double(userDetailModel.publicRepos) / prePage))
        layoutSetup()
        repositoriesRequest()
    }
    
    
    /// UI周りのセット
    func layoutSetup() {
        navigationItem.title = "リポジトリ一覧"
        iconImageView.loadImage(with: userDetailModel.avaterURL)
        nameLabel.text = userDetailModel.login
        fullNameLabel.text = userDetailModel.name
        repositryCountLabel.text = String(userDetailModel.publicRepos)
        followersLabel.text = String(userDetailModel.followers)
        followingLabel.text = String(userDetailModel.following)
    }
    
    /// リポジトリ一覧取得
    func repositoriesRequest() {
        let request = RepositoriesRequest(userPageURL: userDetailModel.reposURL, query: nil)
        APICliant.call(request, disposeBag, onSuccess: { response in
            self.repositoriesModel = response.filter{$0.fork == false}
        }, onError: {error in
            print(error)
        })
    }
}

extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "WebViewController",bundle: nil)
        guard let viewController =  storyboard.instantiateInitialViewController() as? WebViewController else { return }
        viewController.urlString = repositoriesModel[indexPath.row].htmlURL
        present(viewController, animated: true)
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositorieCell", for: indexPath) as! RepositorieCell
        cell.setup(repositoriesModel: repositoriesModel[indexPath.row])
        print(repositoriesModel[indexPath.row].fork)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 追加読み込みの処理
        if repositoriesModel.count < userDetailModel.publicRepos &&
            currentPage < maxPage &&
            indexPath.row == (repositoriesModel.count - repositoriesModel.count/2) {
            currentPage += 1
            let request = RepositoriesRequest(userPageURL: userDetailModel.reposURL, query: [["page":currentPage]])
            APICliant.call(request, disposeBag) { response in
                self.repositoriesModel.append(contentsOf: response.filter{$0.fork == false})
            } onError: { error in
                print(error)
            }
            
        }
    }
}
