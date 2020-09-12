//
//  Loader.swift
//  Template
//
//  Created by Nicolas Wang on 12/09/2020.
//  Copyright © 2020 Nicolas. All rights reserved.
//

import UIKit

class Loader: UIView {
    
    static var sharedLoader: Loader = Loader.loadFromXib()

    @IBOutlet private weak var holderView: UIView! {
        didSet {
            holderView.backgroundColor = .white
        }
    }
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    
    var frontWindow: UIWindow?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    private func customizeUI() {
        self.frontWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        holderView.cornerRadius(radius: 4)
    }
    
    func start() {
        isHidden = false
        frontWindow?.endEditing(true)
        frontWindow?.addSubview(self)
        activity.startAnimating()
    }
    
    func hide() {
        activity.stopAnimating()
        isHidden = true
        self.removeFromSuperview()
    }
}
