//
//  DetailModule.swift
//  RedditPost
//
//  Created by Nicolas Wang on 09/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation
import UIKit

protocol DetailModuleProtocol: AnyObject {
    func detailView(with item: RedditModel) -> UIViewController
}

class DetailModule: DetailModuleProtocol {
    func detailView(with item: RedditModel) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(item: item)
        
        presenter.view = view
        view.presenter = presenter
        return view
    }
}
