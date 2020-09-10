//
//  DetailPresenter.swift
//  RedditPost
//
//  Created by Nicolas Wang on 09/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol: AnyObject {
    var item: RedditModel? { get set }
    func save()
}

class DetailPresenter: DetailPresenterProtocol {
    
    var item: RedditModel?
    var view: DetailView?
    init(item: RedditModel) {
        self.item = item
    }

    func save() {
        if let imagestring = item?.data?.thumbnail, let url = URL(string: imagestring),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {
            view?.save(image: image)
        }
    }
}
