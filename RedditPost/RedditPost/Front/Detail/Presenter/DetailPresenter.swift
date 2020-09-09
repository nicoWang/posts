//
//  DetailPresenter.swift
//  RedditPost
//
//  Created by Nicolas Wang on 09/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    var item: RedditModel? { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    var item: RedditModel?
    
    init(item: RedditModel) {
        self.item = item
    }
}
