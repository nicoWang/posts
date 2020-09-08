//
//  UITableViewCell.swift
//  RedditPosts
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell: NibLoadableView { }

extension UITableViewCell: ReusableView { }

extension UITableViewCell {
    func clearInit() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
