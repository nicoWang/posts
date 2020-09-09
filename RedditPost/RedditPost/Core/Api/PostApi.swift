//
//  PostApi.swift
//  RedditPost
//
//  Created by Nicolas Wang on 09/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation

protocol PostApiProtocol: AnyObject {
    func getPosts(completion: @escaping (_ posts: [RedditModel]) -> Void)
}

final class PostApi: PostApiProtocol {
    
    var interactor: PostInteractorProtocol?
    
    func getPosts(completion: @escaping ([RedditModel]) -> Void) {
        Request<[RedditModel]>.get(self, path: "data.children", url: Constants.posturl, success: completion)
    }
}

extension PostApi: RequestDelegate {
    func onError() {
    
    }
}
