//
//  PostPresenter.swift
//  RedditPost
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation
import UIKit

protocol PostPresenterProtocol: AnyObject {
    var posts: [RedditModel]? { get set }
    func numberOfRows() -> Int
    func post(at index: Int) -> RedditModel?
    func viewDidLoad()
    func reloadPosts()
    func didSelectItem(at index: Int)
    func removeItem(at index: Int)
    func dismissAll()
}

class PostPresenter: PostPresenterProtocol {
    private let view: PostView
    var interactor: PostInteractorProtocol?
    var wireframe: PostWireframeProtocol?
    var posts: [RedditModel]?
    
    init(view: PostView) {
        self.view = view
    }
    
    func viewDidLoad() {
        bind()
    }
    
    func numberOfRows() -> Int {
        guard let rows = posts?.count else { return 0 }
        return rows
    }
    
    func post(at index: Int) -> RedditModel? {
        guard let posts = self.posts, posts.count > index else { return nil }
        return posts[index]
    }
    
    func didSelectItem(at index: Int) {
        guard let posts = self.posts, posts.count > index else { return }
        var item = posts[index]
        item.data?.visited = true
        self.posts?[index] = item
        view.refresh()
        wireframe?.pushToDetail(with: item)
    }
    
    func reloadPosts() {
        getPosts()
    }
    
    func removeItem(at index: Int) {
        guard let posts = self.posts , posts.count > index else { return }
        self.posts?.remove(at: index)
        self.view.remove(at: index)
    }
    
    func dismissAll() {
        posts = []
    }
}

private extension PostPresenter {
    func bind() {
        getPosts()
    }
    
    func getPosts() {
        Loader.sharedLoader.start()

        interactor?.getPosts(completion: { posts in
            DispatchQueue.main.async {
                Loader.sharedLoader.hide()
                self.posts = posts
                self.view.refresh()
            }
        })
    }

}
