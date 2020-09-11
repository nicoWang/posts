//
//  PostCell.swift
//  RedditPosts
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import UIKit

protocol PostCellDelegate: AnyObject {
    func buttonPressed(at index: Int)
}

class PostCell: UITableViewCell {

    weak var delegate: PostCellDelegate?
    private var index: Int = 0
    
    @IBOutlet weak var readedView: UIView! {
        didSet {
            readedView.backgroundColor = .blue
            readedView.layer.masksToBounds = true
            readedView.layer.cornerRadius = 5
            readedView.isHidden = true
        }
    }
    @IBOutlet private weak var topLabel: UILabel! {
        didSet {
            topLabel.textColor = .white
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 3
            titleLabel.textColor = .white
        }
    }
    @IBOutlet private weak var commentsLabel: UILabel! {
        didSet {
            commentsLabel.textColor = .orange
        }
    }
    
    @IBOutlet private weak var dismissButton: UIButton! {
        didSet {
            dismissButton.setTitleColor(.white, for: .normal)
            dismissButton.setTitle("Dismiss Post", for: .normal)
            dismissButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            dismissButton.setImage(UIImage(systemName: "multiply.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
            dismissButton.tintColor = .orange
            dismissButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
            dismissButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        }
    }
    @IBOutlet private weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .black
        accessoryType = .disclosureIndicator
    }
    
    func update(with item: Any?, and index: Int) {
        self.index = index
        guard let data = item as? RedditModel, let post = data.data else { return }
        readedView.isHidden = post.visited
        titleLabel.text = post.title
        topLabel.text = post.author
        commentsLabel.text = "\(post.numComments ?? 0) comments"
        if let icon = post.thumbnail {
            iconImageView.imageFromURLWithCache(url: icon)
        }
    }
    
    @objc func buttonPressed() {
        delegate?.buttonPressed(at: index)
    }
}
