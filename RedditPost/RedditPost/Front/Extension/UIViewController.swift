//
//  UIViewController.swift
//  RedditPost
//
//  Created by Nicolas Wang on 10/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func showAlert(_ title: String? = "", _ message: String? = "", _ buttonTitle: String? = "") {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: buttonTitle, style: .default))
         present(ac, animated: true)
    }
}
