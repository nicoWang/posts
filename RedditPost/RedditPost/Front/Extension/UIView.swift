//
//  UIView.swift
//  RedditPosts
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    static func loadFromXib<T>(withOwner: Any? = nil, options: [AnyHashable: Any]? = nil) -> T where T: UIView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: withOwner, options: options as? [UINib.OptionsKey : Any]).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
    
    func cornerRadius(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
