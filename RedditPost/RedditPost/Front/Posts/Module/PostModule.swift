//
//  PostModule.swift
//  RedditPost
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation
import UIKit

protocol PostModuleProtocol: AnyObject {
    func postViewController() -> UIViewController
}

class PostModule: PostModuleProtocol {
    func postViewController() -> UIViewController {
        let view = PostViewController()
        return view
    }
}
