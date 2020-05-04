//
//  DefaultImageLoader.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit
import Kingfisher
import PromiseKit

struct DefaultImageLoader: ImageLoader {

    // MARK: - Instance Methods

    @discardableResult
    func loadImage(
        for url: URL,
        in imageView: UIImageView,
        placeholder: UIImage?,
        showIndicator: Bool
    ) -> Promise<Void> {
        return Promise(resolver: { seal in
            if showIndicator {
                imageView.kf.indicatorType = .activity
            }

            imageView.kf.setImage(with: url, placeholder: placeholder, completionHandler: { result in
                switch result {
                case .success:
                    seal.fulfill(())

                case .failure(let error):
                    seal.reject(error)
                }
            })
        })
    }

    func cancelLoading(in imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
    }

    func loadImage(for url: URL, in button: UIButton) {
        button.kf.setImage(with: url, for: .normal)
    }

    // MARK: -

    func isImageCached(forKey key: String) -> Bool {
        return ImageCache.default.imageCachedType(forKey: key).cached
    }

    func loadImage(forKey key: String, in imageView: UIImageView, scaleFactor: CGFloat) -> Promise<Void> {
        return Promise(resolver: { seal in
            ImageCache.default.retrieveImage(forKey: key, options: [.scaleFactor(scaleFactor)], completionHandler: { result in
                DispatchQueue.main.async(execute: {
                    switch result {
                    case .success(let imageCacheResult):
                        imageView.image = imageCacheResult.image
                        seal.fulfill_()

                    case .failure(let error):
                        seal.reject(error)
                    }
                })
            })
        })
    }

    func save(image: UIImage, forKey key: String) {
        ImageCache.default.store(image, forKey: key)
    }
}
