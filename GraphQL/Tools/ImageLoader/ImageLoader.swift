//
//  ImageLoader.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit
import PromiseKit

protocol ImageLoader {

    // MARK: - Instance Methods

    @discardableResult
    func loadImage(
        for url: URL,
        in imageView: UIImageView,
        placeholder: UIImage?,
        showIndicator: Bool
    ) -> Promise<Void>

    func loadImage(for url: URL, in button: UIButton)

    func cancelLoading(in imageView: UIImageView)

    func isImageCached(forKey key: String) -> Bool
    func loadImage(forKey key: String, in imageView: UIImageView, scaleFactor: CGFloat) -> Promise<Void>
    func save(image: UIImage, forKey key: String)
}

// MARK: -

extension ImageLoader {

    // MARK: - Instance Methods

    @discardableResult
    func loadImage(
        for url: URL,
        in imageView: UIImageView,
        placeholder: UIImage? = nil,
        showIndicator: Bool = false
    ) -> Promise<Void> {
        return self.loadImage(for: url, in: imageView, placeholder: placeholder, showIndicator: showIndicator)
    }

    func loadImage(forKey key: String, in imageView: UIImageView, scaleFactor: CGFloat = 1.0) -> Promise<Void> {
        return self.loadImage(forKey: key, in: imageView, scaleFactor: scaleFactor)
    }
}
