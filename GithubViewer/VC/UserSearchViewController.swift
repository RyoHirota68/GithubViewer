//
//  ViewController.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/06.
//

import UIKit
import RxSwift
import Alamofire

class UserSearchViewController: UIViewController {
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let defaultPage = 1
    private var currentPage = 1
    private let prePage = 50
    private var searchUserName: String = ""
    let disposeBag = DisposeBag()
    
    private var userModels: [UserModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ユーザー検索"
        userSearchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")}
}


extension UserSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let searchUserName = searchBar.text {
            self.searchUserName = searchUserName
            self.currentPage = self.defaultPage
            let request = UserSearchRequest(query: [["q":self.searchUserName],["page":defaultPage],["per_page":prePage]])
            
            APICliant.call(request, disposeBag, onSuccess: {response in
                self.userModels = response.items
                self.tableView.setContentOffset(.zero, animated: false)
            }, onError: {error in
              // error handling
                print(error)

            })
        }
    }
}

extension UserSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reqest = UserDetailRequest(userPageURL: userModels[indexPath.row].url)
        APICliant.call(reqest, disposeBag, onSuccess: {response in
            let storyboard = UIStoryboard(name: "UserDetailViewController",bundle: nil)
            guard let viewController =  storyboard.instantiateInitialViewController() as? UserDetailViewController else { return }
            viewController.userDetailModel = response
            self.navigationController?.pushViewController(viewController, animated: true)
        }, onError: {error in
            
        })
    }
}

extension UserSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.setup(userModel: userModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 追加読み込みの処理
        if userModels.count >= prePage && indexPath.row == (userModels.count - 15) {
            currentPage += 1
            let request = UserSearchRequest(query: [["q":self.searchUserName],["page":currentPage],["per_page":prePage]])
            APICliant.call(request, disposeBag) { response in
                self.userModels.append(contentsOf: response.items.map{$0})
            } onError: { error in
                print(error)
            }

        }
    }
}
