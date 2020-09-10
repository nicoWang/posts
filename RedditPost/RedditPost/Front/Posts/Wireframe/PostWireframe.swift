//
//  PostWireframe.swift
//  RedditPost
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation
import UIKit

protocol PostWireframeProtocol: AnyObject {
    func pushToDetail(with item: RedditModel)
}

class PostWireframe: PostWireframeProtocol {
    
    var navigation: UINavigationController?
    
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func pushToDetail(with item: RedditModel) {
        let module = DetailModule()
        let view = module.detailView(with: item)
        navigation?.pushViewController(view, animated: true)
    }
}
