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
    func postViewController() -> UISplitViewController
}

class PostModule: PostModuleProtocol {
    func postViewController() -> UISplitViewController {
        let view = PostViewController()
        let navigation = UINavigationController(rootViewController: view)
        let api = PostApi()
        let interactor = PostInteractor(api: api)
        let presenter = PostPresenter(view: view)
        let wireframe = PostWireframe(navigation: view.navigationController)
        
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.presenter = presenter
        
        api.interactor = interactor
        
        let detailView = DetailViewController()
        let detailPresenter = DetailPresenter(item: RedditModel())
        
        detailPresenter.view = detailView
        detailView.presenter = detailPresenter
        view.presenter = presenter
        wireframe.delegate = detailPresenter
        
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [navigation, detailView]
        splitViewController.delegate = view

        return splitViewController
    }
}
