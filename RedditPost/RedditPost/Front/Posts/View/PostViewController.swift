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
    func remove(at index: Int)
}

final class PostViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var dismissButton: UIButton! {
        didSet {
            dismissButton.setTitleColor(.orange, for: .normal)
            dismissButton.addTarget(self, action: #selector(dismissAll), for: .touchUpInside)
        }
    }
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
    
    func remove(at index: Int) {
        tableView.performUpdate({
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .right)
        }, completion: {
            self.tableView.reloadData()
        })
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = presenter?.numberOfRows() else { return 0 }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.delegate = self
        if let post = presenter?.post(at: indexPath.row) {
            cell.update(with: post, and: indexPath.row)
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

extension PostViewController: PostCellDelegate {
    func buttonPressed(at index: Int) {
        presenter?.removeItem(at: index)
    }
}
private extension PostViewController {
    func bind() {
        Loader.sharedLoader.start()

        title = "Reddit Posts"
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
    
    @objc func dismissAll() {
        UIView.animate(withDuration: 1, animations: {
            self.tableView.alpha = 0
        }, completion: { _ in
            self.presenter?.dismissAll()
        })
    }
}

extension PostViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
