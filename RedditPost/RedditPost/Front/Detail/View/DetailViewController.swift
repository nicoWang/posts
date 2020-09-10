//
//  DetailViewController.swift
//  RedditPost
//
//  Created by Nicolas Wang on 09/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import UIKit

protocol DetailView: AnyObject {
    func save(image: UIImage)
}

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapPressed))
            iconImage.addGestureRecognizer(tap)
            iconImage.isUserInteractionEnabled = true
        }
    }
    @IBOutlet private weak var descLabel: UILabel! {
        didSet {
            descLabel.numberOfLines = 0
        }
    }
    
    var presenter: DetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension DetailViewController: DetailView {
    func bind() {
        guard let item = presenter?.item, let post = item.data  else { return }
        titleLabel.text = post.author
        descLabel.text = post.title
        if let icon = post.thumbnail {
            iconImage.imageFromURLWithCache(url: icon)
        }
    }
    
    @objc func tapPressed() {
        presenter?.save()
    }
    
    func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlert("Save error", error.localizedDescription, "OK")
        } else {
            showAlert("Saved!", "The screenshot has been saved to your photos.", "OK")
        }
    }
}
