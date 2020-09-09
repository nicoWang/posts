//
//  PostInteractor.swift
//  RedditPost
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation

protocol PostInteractorProtocol: AnyObject {
    func getPosts(completion: @escaping (_ posts: [RedditModel]) -> Void)
}

final class PostInteractor: PostInteractorProtocol {
    var presenter: PostPresenterProtocol?
    private let api: PostApiProtocol
    
    init(api: PostApiProtocol) {
        self.api = api
    }
    
    func getPosts(completion: @escaping ([RedditModel]) -> Void) {
        api.getPosts(completion: completion)
    }
}
