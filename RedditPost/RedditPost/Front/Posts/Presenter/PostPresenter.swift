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
    func post(at index: Int) -> RedditPostModel?
}

class PostPresenter: PostPresenterProtocol {
    private let view: PostView
    private let interactor: PostInteractorProtocol
    private let wireframe: PostWireframeProtocol
    
    init(view: PostView,
         interactor: PostInteractorProtocol,
         wireframe: PostWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func numberOfRows() -> Int {
        return 0
    }
    
    func post(at index: Int) -> RedditPostModel? {
        return RedditPostModel()
    }
}
