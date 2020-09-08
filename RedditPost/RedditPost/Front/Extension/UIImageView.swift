//
//  UIImageView.swift
//  RedditPosts
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFromURLWithCache(url: String, imagePlaceholder: UIImage? = nil, imageDefault: UIImage? = nil) {
        if let imgUrl = url as String?, imgUrl.isEmpty {
            self.image = imageDefault
            return
        }
        
        let cache = URLCache.shared
        let imgURL = URL(string: url)
        let request = URLRequest(url: imgURL!)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            if imagePlaceholder != nil{
                self.image = imagePlaceholder
            }
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = imageDefault
                    }
                    return
                }
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.image = imageDefault
                    }
                }
            }).resume()
        }
    }
}
