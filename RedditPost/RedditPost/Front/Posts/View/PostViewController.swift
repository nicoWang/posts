//
//  PostViewController.swift
//  RedditPost
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import UIKit

protocol PostView: AnyObject {
    
}

final class PostViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: PostPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension PostViewController: PostView {
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = presenter?.numberOfRows() else { return 0 }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
}

private extension PostViewController {
    func bind() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self)
        tableView.rowHeight = UITableView.automaticDimension
    }
}
