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
    func numberOfRows() -> Int
    func post(at index: Int) -> RedditModel?
    func viewDidLoad()
    func reloadPosts()
    func didSelectItem(at index: Int)
    func removeItem(at index: Int)
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
    
    func didSelectItem(at index: Int) {
        guard let posts = self.posts, posts.count > index else { return }
        let item = posts[index]
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
