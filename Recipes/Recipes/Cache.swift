// Cache.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол загрузки изображений
protocol LoadImageServiceProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

/// Сервис загрузки изображений
final class LoadImageService: LoadImageServiceProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}
