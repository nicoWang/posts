//
//  PostViewController.swift
//  RedditPost
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import UIKit

protocol PostView: AnyObject {
    func refresh()
}

final class PostViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    var presenter: PostPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension PostViewController: PostView {
    func refresh() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        tableView.reloadData()
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = presenter?.numberOfRows() else { return 0 }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if let post = presenter?.post(at: indexPath.row) {
            cell.update(with: post)            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.row)
    }
}

private extension PostViewController {
    func bind() {
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self)
        presenter?.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(reloadPosts), for: .valueChanged)
        refreshControl.tintColor = .white
        tableView.addSubview(refreshControl)
    }
    
    @objc func reloadPosts() {
        presenter?.reloadPosts()
    }
}
