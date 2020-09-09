//
//  RedditModel.swift
//  RedditPost
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation

struct RedditModel: Codable {
    var kind: String?
    var data: RedditPostModel?
}

struct RedditPostModel: Codable {
    var id: String?
    var title: String?
    var author: String?
    var numComments: Int?
    var thumbnail: String?
    var createdUtc: Double?
    var visited: Bool = false
    var saved: Bool = false
    var authorFullname: String?
}
