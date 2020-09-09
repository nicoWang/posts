//
//  PostPresenter.swift
//  RedditPost
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation

protocol PostPresenterProtocol: AnyObject {
    func numberOfRows() -> Int
    func post(at index: Int) -> RedditModel?
    func viewDidLoad()
    func reloadPosts()
}

class PostPresenter: PostPresenterProtocol {
    private let view: PostView
    var interactor: PostInteractorProtocol?
    var wireframe: PostWireframeProtocol?
    private var posts: [RedditModel]?
    
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
    
    func reloadPosts() {
        getPosts()
    }
}

private extension PostPresenter {
    func bind() {
        getPosts()
    }
    
    func getPosts() {
        interactor?.getPosts(completion: { posts in
            DispatchQueue.main.async {
                self.posts = posts
                self.view.refresh()
            }
        })
    }

}
